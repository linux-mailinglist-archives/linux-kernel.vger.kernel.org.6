Return-Path: <linux-kernel+bounces-367480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35199A02D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ACA28A758
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AB1C4A3B;
	Wed, 16 Oct 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="d8i8Rk7+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D31C4A03
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064461; cv=none; b=txIysXqQRHNEQdLSzJUomutkuY4AiyxKPLtB9sR/wrL8LQ+QlihtdYLKyYX25qT+J9lQVgfvW44ENHzY6BoyG1S644kZ1At2lTUCy1uGAC+9tS6d6u5JIhkZjZzy28ijD5x22ZQ45a7hSa50/Ot7Qd9XqZL7kBhk2U6wQivL0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064461; c=relaxed/simple;
	bh=cJqezZ//VWL04ujmf8HWK5yYC5mIb/17KND/yhYfcug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDmo81zk9hIivjIiAidZjxtyJ8DAdQ+k6vEambenqh2Ovra1S2Sz4OQqtW/g2eJNxopGWAzkzzx2AYEFczfDzE38T32tSFSdptNaLqYRPVhXIi1qLQQp3oXWFfVjhILi/gWCCPnqceKGKKM/Xw9INHcJYQMl1AAvbpRDr8db4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=d8i8Rk7+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f629a7aaso109629566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729064458; x=1729669258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMVFl2GTcBmobaI+bMD3OiVaYIUMWW+lDjeTxVFsk50=;
        b=d8i8Rk7+FmeRQ0I01AsrDRGriqNRaoakFIRSzhg8XTUAQjlEuXErJHaGjTibN457fw
         /m/wYGoUfnfAKPnexzTv0D9LD6iqBTtjJp6Ct8Kzr53p5Dt6cGD4hrZvYjBdIRqGYQln
         jMzP3YS4QDnGLfnKqkS8uJmBlInijJhJQOgtGvh/s8/aC7epX/eya13lOu07YIiEAKOJ
         zur7gNvAPePdWQy6G7GnZGY04EUQgKlbQJMS/TqoqMph0X6Xhe/Q3sq7spvnvvmSdU53
         TmXsIcf2bNnAqOEPN5/LC27/knr3q8DYlkXe9xJwzIwkmss0ug5FKOFdOt2Vq9N6pGIb
         LvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064458; x=1729669258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMVFl2GTcBmobaI+bMD3OiVaYIUMWW+lDjeTxVFsk50=;
        b=k0WUm86GWFBhAT7UknS3VRI3x1MljaSfJvbdblAFDXG7LSlP5tCLfPUhsr7fpP0Rwr
         jt/SGSw5pO+ryj9femo3KowV5Qzl5d4bAdALQB8HqZDKcMnt9pXd9XN8EFgy9fU94fCa
         oyWDYPt9a8L+E376L/lchXLyWiAeL1jKNdOw1UTWJGcsl9+zdWjOce5PrWlB8LA/CvcU
         rWZcnqxIFJV0rUjFpSIKXqJYpNdnPIZuFMElKb0d+m9FD3QymLZCEoPqFPXZNdK6QIid
         ncflf+zdmfNupB1XsbEMU+/Mgj9Nr/wuJK26qnfw5kF+Dx0AtYoy172H4tztUcqqVGzz
         PfWw==
X-Forwarded-Encrypted: i=1; AJvYcCXOmpsf7Q2/+YvKDxAkuU3WZQN15lGwfxsL7GaJxXex4PFadhAmzVhDvp2LSMC0VIeyoWgVxLtQOr0HihQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBaeOoQbAwl1WCPFIVwdVFxzBfDumVR7MigE9DlikXLfmifWc
	9M1Ge74OhE4gqspDBiESeRNlb3NCNfCUJ9t8dkajRuHvlQDFJkyKlAt1fV9hlcrXyn1vc3uFXbI
	lV9CAkzu8g4AJpCKCCrIZuImCwoa0Ev2H/uY40g==
X-Google-Smtp-Source: AGHT+IHWv4dKp5kG/i7bSz1apYnsRrEAbrQx4o5iragJJJrMK8m5N8TwV7V7U2xGrwr0JUKngMV/CdjYcW62YtcG88Y=
X-Received: by 2002:a17:907:6d21:b0:a99:ff33:9ba5 with SMTP id
 a640c23a62f3a-a9a336c5625mr270100066b.24.1729064457805; Wed, 16 Oct 2024
 00:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015210300.17941-1-everestkc@everestkc.com.np> <2024101654-creole-palm-81d4@gregkh>
In-Reply-To: <2024101654-creole-palm-81d4@gregkh>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 16 Oct 2024 01:40:46 -0600
Message-ID: <CAEO-vhEiMG+Zb0-FqPBcYANnpnntA-H_D76wbAehgXDAUTYKOg@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Remove unused value
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:37=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Oct 15, 2024 at 03:02:57PM -0600, Everest K.C. wrote:
> > The variable `complement_count` is assigned a value which is again
> > overwritten in the next statement.
> > Fix this by removing the first value assigning statement
> >
> > This issue was reported by Coverity Scan.
> > Report:
> > CID 1600790: (#1 of 1): Unused value (UNUSED_VALUE)
> > assigned_value: Assigning value from length to complement_count here,
> > but that stored value is overwritten before it can be used.
> >
> > Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB =
driver")
>
> Thre is no "fix" needed here.  It's not a bug, just a useless operation
> (one tha tthe compiler probably just compiles away into nothing.)  So
> there is no need for a Fixes: tag, sorry.
Noted. Will remove the fixes tag and send V2.
> thanks,
>
> greg k-h
Thanks,
Everest K.C.

