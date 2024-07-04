Return-Path: <linux-kernel+bounces-240659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F670927090
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F8A2874EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6A1A254E;
	Thu,  4 Jul 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNr5GGcO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCF1A0AFA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078118; cv=none; b=P04XKsy1EHoxZEHp3U77MxTImSmNZIxcXNLoujSEfLNgszaltsbs06ojDRHcPNk9kkgZJo0DNl/1h5mdvXNyIXw1nXVSvSMF3SNB+8CV5p9xqZUPOGG6zqe4/fd9d5y7XZ9oh0e7ezvmuebhPJLe3mIJDiFUlB345Rqkm4pS9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078118; c=relaxed/simple;
	bh=YXs8cgT/wMh5raP4CBIWj9ffPIuFhyYfSJpRvlOtqcE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jrv0whLFkjoxYkUsZL+SRc6v2Bdn6g15ThCJgUdTdbehBep1m9JPCGqlwZMfsHK9Euku/UDfsejhrqLLDfmKEoS+iTI8+nCAZtYZH7ekU9elFcyuDgoEw1IEm8HKYvM1Jwp5oj3JxRozcV+eLLoA3gdb/fZHCw0eh/zbtEXYyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNr5GGcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720078116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvbJILSJxkt6UdWhQQUecUb1XAMG0H35Fa4mDS2O+Dw=;
	b=PNr5GGcO2Swouobg+Tt/SdJ1gaeuFl9aebA8shAW4VhcnDAwpQ3YdVvGTIqrrNebFHgyXf
	4FkeYIi/uGfv6/O7EaY/YlzdXcFeHDrzbDiSP4Jz5/Zg2QNAfV1IXiS77/agVDXUL6SVuM
	cq9rNU780Tc8g+Gb98mOvfk8kk84Pps=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-lTvpotFaPpSF_Y6QVG8w4A-1; Thu, 04 Jul 2024 03:28:34 -0400
X-MC-Unique: lTvpotFaPpSF_Y6QVG8w4A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5ebdd8109so5203276d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078114; x=1720682914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AvbJILSJxkt6UdWhQQUecUb1XAMG0H35Fa4mDS2O+Dw=;
        b=E5Ed03UCV5CCRtx632HM18OROkmRKenSzm5ON+IooR6JKi8bUxY+u4KEe3Y6/FTSyT
         o4pcm61LXPCE5ElZhAkQ936cLxC/W/p8/+SeixZOqGmMq+zAJDxJiRucXNq6q2CPfKum
         HkUhsU7y83qPz+StGM+B1rB+Ux0O3U8FWFT10e6XtpiXiOafWodr0FUlwgAYRfwFOy64
         vcUhqHApXZYnPz+xuGNPOTG/VEXI+CkSib+sAFrveqOXEi0TEu8EqKvKii0V7APo5hqk
         BJBNTv1rSEOEzvWff58jeYHbXc/6fY9cgzMjtP+tG9I96tUsd7e4cKyr25Wn1wIbfP3f
         H29w==
X-Forwarded-Encrypted: i=1; AJvYcCXCrKuJMRGC9SdKWod5Sh2xCyk1HJkMNuwMFRk0P37vpNwK1zJH9sRoYattOhS3+fDz41FrusaQDsoJCMftTvkmoorb8zFA25YvuEbu
X-Gm-Message-State: AOJu0YwJodYYKn+mTwFVmcjWQR9FSqM60Hu8iuxEe7ITS5jyTTXoRCFU
	Ilm2G7NthL9r5BzwMqu+JRgqNIh2v4JekCtcVfhc7ahLHGSj2iSCy/jBAI9inznQ7soJx2iygvn
	EDzdIgmiD8OODgKon39U2UBO29xJHSnpagbIA6Dko/+jNM8CIPl6gzkYdu1vGtriR5Aq5kEfY5f
	LyD6XqFqxRlO+WeG3fczpK2sF8Fa5Mi2mqbR8g
X-Received: by 2002:ad4:5cad:0:b0:6b5:2655:4518 with SMTP id 6a1803df08f44-6b5ecfb62femr8275996d6.20.1720078114455;
        Thu, 04 Jul 2024 00:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkb9qyz5cfjppp3EFyiqrqSOSa6sg8iHdFvSW2awFrFhVoyLlJQdPk1YTJv/0mtSfHUtHi9GRXWC4Cfxpm3PE=
X-Received: by 2002:ad4:5cad:0:b0:6b5:2655:4518 with SMTP id
 6a1803df08f44-6b5ecfb62femr8275926d6.20.1720078114175; Thu, 04 Jul 2024
 00:28:34 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jul 2024 00:28:33 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240702095336.596506-1-amorenoz@redhat.com> <20240703193519.16305196@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240703193519.16305196@kernel.org>
Date: Thu, 4 Jul 2024 00:28:33 -0700
Message-ID: <CAG=2xmMGcLiN94G_f21kFaj18+36XPBZUos7KD4GEZAZ9794Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/10] net: openvswitch: Add sample multicasting.
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 07:35:19PM GMT, Jakub Kicinski wrote:
> On Tue,  2 Jul 2024 11:53:17 +0200 Adrian Moreno wrote:
> >   selftests: openvswitch: add psample action
> >   selftests: openvswitch: add userspace parsing
> >   selftests: openvswitch: parse trunc action
> >   selftests: openvswitch: add psample test
>
> Sorry for applying things slightly out of order but without Aaron's
> patches we can't check if these work in our CI. Unfortunately, they
> conflict, could you respin one more time?

No problem. I'll respin.

Adri=C3=A1n

> --
> pw-bot: cr
>


