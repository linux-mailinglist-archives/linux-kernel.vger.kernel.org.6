Return-Path: <linux-kernel+bounces-305357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C2962D73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AB7B230F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC321A3BA1;
	Wed, 28 Aug 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTtZ7da2"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B91A4F1E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861709; cv=none; b=fBt6rMjYUH1o/v8eXL6U7R+SXs+vjAHRZtlYKSjvrWP3M3gtMKOQ/klIGOwtKWv7zbUIRnGrR8eGig0v8pcxA8vKWRXLM9rdn++mCnAXy7740pe08zqANrjZpSkWP17ydjBBrAa5K83LESF+MdXkDKyONtcfJScUT5Pn5zOwUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861709; c=relaxed/simple;
	bh=Okmgsan3LUVkkzZFXpwqucFWbJOTa7oheGqbn5qPhbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNcl+0sugFAolRMDPl/mMJJNVMlc55hE3iZRWKtvXntxdr1BFwCzMAqY/THkVIuFsfVwyq4g3QKuHl4FbSgw+gwZdpBAJqrCtMBVUoLy970yn/hCuplB4kzzq9jSpfX2IpLv8/BTE5Y8DhT3CgKSlu/i8s501H+hxZa9u+BdYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTtZ7da2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db10d8830aso128790b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724861707; x=1725466507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuEwGIpDkqfIpxW0bgF/RVPt4IxIPFyBx9pLhSVN2JI=;
        b=gTtZ7da2HWgtPhxpewC7T3BDMHih4kiyC2GhbsisGD+eLJxEuuk+y+NwO2hN+xx3Ub
         SeuorL9ApgDhaYfOKv70rR0/auefljv6uBgj2bEDiO74N1OE+0VuwW1ZNaqUS7FEfTcw
         OPl/zl0MrqTwuENhC8H+q2Mwj2OxrFj7vhIvGQJ6hwWf0HQZoNsFrOc6sfFx8Z8fGrJx
         UXb59etx5vgSuDADoxzdWUIq5Cs5bawkcxABZ0Yd8GgGdLZS+ODwby8vXdzcKlwTfFCw
         bMqX5hqDGkQcPUb1DAF4WjccGvjY4xFbS2w62V/0iR8cMQBUYMfL3t9/bBjt5O5Nm+zg
         QIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861707; x=1725466507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuEwGIpDkqfIpxW0bgF/RVPt4IxIPFyBx9pLhSVN2JI=;
        b=CAzjQIREx0zFiKyvJ+NBLPDv4bDHn3Ixmnfhwx7fXOfKxnQj7i+7TqR8wmNPahhbch
         I48Qh0C9VWR7p0bgCY7OPYYwjEbmejDTCjScfD3d86EBluJ3UI4+mHSIPtm/ckIQAlow
         SCQihP7fURg/H6U0ix+PqI8hQMN9t6cL71QoKCsptT2zHrQgHVv/epE4PWnIYLFw/4pk
         eZCzUXYmSTeC2L7TJ+mmmvgF5A+0fu/+tTpKv45RifwGu+Ne/PTUJVhTSNuIwMzp7zW1
         i17pn+paIgkjqV0LKWqMWWKEizpv2ryq5dO0C0RNGWPMctLvLp7Jf3t/k2ou3dZRDF4i
         QpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNFPniCUVAyF20BXhWmMLr/rY2FQxAUSayJxpzMq0iqsDdRcmZZgT/cW4Itlb6H/QLfhDW8H3t7U/sWT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJE86IncgGdo23AqOnDjAJ22gCUJisz4GRW1QdZiDs7ZuKMGx2
	ri6zSgeA67msaxj0caeijddEcm6pCKVVAcY35MFxzVIuECGo4/3QDBgIQH+SZae41XCI4r/Fdpn
	IClNBy2JcFIRi+ElKg/dFkvq20wk=
X-Google-Smtp-Source: AGHT+IEKPm0X049OLCCWte/lKWA1onDQZDte91zJigx88Na7YtcnnIcK4NXUHhl/qlfnTtpRZbsgkb9gE5ObhgepknQ=
X-Received: by 2002:a54:4405:0:b0:3db:291e:2467 with SMTP id
 5614622812f47-3de2a8a90a3mr8754550b6e.7.1724861706964; Wed, 28 Aug 2024
 09:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3EA7C2B9E8C4D00A+20240828105938.37674-1-wangyuli@uniontech.com>
 <CADnq5_P42A81D_VufAdSkwVwC08ZRiT=6XAS3oHmSH325ygbow@mail.gmail.com> <D25D5E6FB683DA94+808c82a3-546f-4289-b531-fa24d7278879@uniontech.com>
In-Reply-To: <D25D5E6FB683DA94+808c82a3-546f-4289-b531-fa24d7278879@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Aug 2024 12:14:55 -0400
Message-ID: <CADnq5_MJTTX0koP7am-D0RoZro=0_e38ic5BoJuKhbyM6y-99g@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: disable amdgpu_dpm on THTF-SW831-1W-DS25_MB board
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, lijo.lazar@amd.com, 
	mario.limonciello@amd.com, le.ma@amd.com, Jun.Ma2@amd.com, 
	hamza.mahfooz@amd.com, andrealmeid@igalia.com, wenlunpeng@uniontech.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com, zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:47=E2=80=AFAM WangYuli <wangyuli@uniontech.com> =
wrote:
>
>
> On 2024/8/28 23:30, Alex Deucher wrote:
> > On Wed, Aug 28, 2024 at 7:28=E2=80=AFAM WangYuli <wangyuli@uniontech.co=
m> wrote:
> >
> > This will disable dpm on all devices that you might install on this
> > platform.  If this is specific to a particular platform and board
> > combination, it might be better to check the platform in the
> > dpm_init() code for the specific chip that is problematic.
> > Additionally, disabling dpm will result in boot clocks which means
> > performance will be very low.
> >
> > Alex
>
> This motherboard model doesn't have combinations with different
> platforms or chipsets now.Their model numbers are unique,so it seems
> unnecessary to add extra judgment.

The error message looks to be from an SI board which is a dGPU.  Is
that dGPU integrated into the motherboard?  Does the motherboard have
PCIe slots?  If there are PCIe slots you could presumably put any GPU
into it and if you did, dpm would be disabled by default.

Alex

