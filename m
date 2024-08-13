Return-Path: <linux-kernel+bounces-284790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43999950527
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771EB1C21E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2DA199E81;
	Tue, 13 Aug 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBatn2AY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F917D8A6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552616; cv=none; b=YQNMN9s3El/Y974puUj/HsB2tKfjaR7PbMdh/3WXEZyCmkJaZT1zzZ1TEoDCtO6eGPyMsYvEyq7xWPserfA837qqTNqHqjhyXynqBRTtrOSpjvh1d/1vcxgFncrQX+5xFlT9GPfNRrLvkj8+8p9ITfN3jlYBHdDW3DIpBDZbXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552616; c=relaxed/simple;
	bh=68SsCUaNEsnCqAjErgExTVGZL/KYU14liaZVe7k297U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j20IEFUUCU4Gy0VUaemsSrtC2PvLVjddTcCwC9yoqQW+2qYmLg5XtR/U1DktqaEgyvi/YPVcQ+hOUS90CU9xkerTWrEs/+jLAo3XmG2Lhai+Uk7stD+eC8cI56/gifER7ZGqe2i1qo6IRyeDN708SeyVjxFnFYbXqgGC4Iqsnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBatn2AY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723552612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0TUSbcTCIH1WGQQ2wF7pJ/BOblSyxCtN4itWRR3eIo=;
	b=PBatn2AYRQGgQuW7b7VqO6reXGKBNfL17CHgl7uxesWPM86AioFsxq76xFZnMX2CQz+i46
	B/qQiE+N1yvdM670QQCC+eBVGGLDxZu4R4Yh4/UnoKfxUlFLWK07c0w9fDcVUmLwz1KRVw
	zxQN2ioJcbPWzi+kgaUn8Yeqq8ElTj8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-TNgGSM8cMD2d-dzXs0Ph7A-1; Tue, 13 Aug 2024 08:36:51 -0400
X-MC-Unique: TNgGSM8cMD2d-dzXs0Ph7A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52f00bde29dso7626961e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552609; x=1724157409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0TUSbcTCIH1WGQQ2wF7pJ/BOblSyxCtN4itWRR3eIo=;
        b=AH1Fa5VjdmNjj9pKGPkB3QeTpLZfflVJYcRv4lBsCxc/XIr2YLjfwy4hFMh0KaugKW
         XUVRiPpvXZQhTgtPal+aHu9qm7SNHPODi07V+Gxn9B2d+kklC+hV7MMcWorU2IG1Z0rB
         yiaEj7nyt19GBaNSO6UXWBT9CUy4sWxQjY1f+OkokQqNds3+BJRUPQeDCefeMZ2tGBZX
         JOizd/yJefTdOpLiEvFBhgBSoR1NAnfHKQjrlw0rsLNKzUvCTF+SAb3TbHX0KJc8uPJW
         s+oiIyynUtc0eMrqQhsrFaDfgjEoOgJTt7szy8LCvQqm1OaZZNIpX5bdNrDV7uBldIkb
         n8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUwzj2EJTjPxmqCtd/JsSzcJuLhS4NTTSmy36NiFHRZx7w/6lgNGmKSOHSQbn/KTIzX2zXkr8FimBsOEZWCDFf+CT/6nm7Lm15msBOA
X-Gm-Message-State: AOJu0Yz4z/kno26p50qq51cepK+oORs4tbt2pf8FrF9KBAw6Nbn996ok
	FZ0ImxbpQht7J2jI62jfqzxB3E2o1bARTlTyB6SQtsvqYRtpVSCMeryU857Aw1J6taJXvVuZWou
	h+Zg0XycKMfVAJi70iydFfZ/FVdVFWb1IHLd2aMrLGy855PuEaT0VQq3Va5hN6hJHHjRrnGj7kA
	JkpnkfuZha2UVlVrXMrbJSUjVlkkDmcI/YfWV2
X-Received: by 2002:a05:6512:3d86:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53213692a78mr2562633e87.52.1723552609345;
        Tue, 13 Aug 2024 05:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7BlMoT6OL41Ug/pNECmFOkEoEPNi3/UKnqqTuK9qlZuO7CRYCYGlTo2lbdBTKuEA/yp7JLiadree+/Y/FFMs=
X-Received: by 2002:a05:6512:3d86:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-53213692a78mr2562595e87.52.1723552608809; Tue, 13 Aug 2024
 05:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813114931.360823-1-ezulian@redhat.com>
In-Reply-To: <20240813114931.360823-1-ezulian@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 13 Aug 2024 14:36:37 +0200
Message-ID: <CAP4=nvROfKr8s75B=POefQozE88se6zrfPcfaP_n5TqtXY9ABQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: Sync the help text between hist tools
To: Eder Zulian <ezulian@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org, jlelli@redhat.com, lgoncalv@redhat.com, 
	jkacur@redhat.com, williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 13. 8. 2024 v 13:49 odes=C3=ADlatel Eder Zulian <ezulian@redhat.com=
> napsal:
>
> In addition, fix a typo in the error message generated when the
> specified duration is invalid.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 4 ++--
>  tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

FYI some of the issues you fixed for hist are also in timerlat_top.c:

        "      -d/--duration time[m|h|d]: duration of the session in second=
s",
...
        case 'd':
            params->duration =3D parse_seconds_duration(optarg);
            if (!params->duration)
                timerlat_top_usage("Invalid -D duration\n");
            break;

and the "Invalid -D duration" (instead of "-d") one is also in
osnoise_top.c. Those would probably go to a separate patch, though.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas


