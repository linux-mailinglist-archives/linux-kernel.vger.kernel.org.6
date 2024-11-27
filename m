Return-Path: <linux-kernel+bounces-423537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989629DA911
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469961653D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964451FCF74;
	Wed, 27 Nov 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Odvt1JiS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4F1FCD18
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715450; cv=none; b=l6CXoO6oLXkxHv9cvTiElH12l947L6+fD5a7vEOQooe8RFyv4VZsPwM32+szrohT+AeDt/8gggXlqfjUYp9Ntd1vRM8L28JpfM8FZvwfaDicwzaS3wkUEzKqKXkabONYkNVTsn0pQkqAZYcNHljIgy6NJ3JEvMs57cNmTDUpjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715450; c=relaxed/simple;
	bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqt2Uty59L33UdrUn8meA0+mTYGAqE5sjiZBMdhEubkvHA7y4dox2qppfNBHPrwtvBr/zuUGC1aicTH8M40FMSs0fcwNu1xyQdP9EEdMKZ+16X/LPA0ccxhah7mal0NYp0w+Zta0kHHn8MKcAI1204lmB7e/S2TNEEII8ulZ7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Odvt1JiS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
	b=Odvt1JiSE9IiCJhfk7/ZrB/q/Ko+GDmuUH5LHVceMIwkIk25Q+Z2mrzLOzX69XMwFL8cYB
	JHu6+ZJcz53mhqhvWRpzS2VodeoPk42/Py3+jxyO6jz5EhSDMxK0NfelY9RGOgYDwN1ykZ
	yp+FfDDBIhkyqBrHm7iVedDaCWjhZQ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-jnobWdrfPj64XNgTLhdt_w-1; Wed, 27 Nov 2024 08:50:46 -0500
X-MC-Unique: jnobWdrfPj64XNgTLhdt_w-1
X-Mimecast-MFC-AGG-ID: jnobWdrfPj64XNgTLhdt_w
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa5438c6b13so233068566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715444; x=1733320244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmLOvKtpz8Fi6Pwt/icSJ05BvKLbLbH9FVoytCdF9F0=;
        b=qn210d9n5NwJuWTjZrm/PiF9rGvh7JF8Nu31P3R0lDE4eVDrgMkhlSd3bm11+w+YWJ
         ZhC3jjB7CUs2v9aZbbm5gkkVuz8ttEQyqoie0wSB/GMUaglyiU9/LwKJ98z4PezYkJvx
         wz1TspR+cTdfo5+YTm5zDdTMFuFqeFmGYILNj9smwBlmcYd65+GRXknu8+NDkZO3+07F
         5X97FDldx4T/NxhBb/kpXrKcxK8Lbd4zcFv2IpcYepmkC2BDPVxCP0YvJbDlFRszeTfX
         a6L5gE35+Af6pSgnEl3ePCB0U+mscB78Eg0n+dcitIeMBbw5yhk2hRIqaO92r65xYzy1
         Vu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ4Y3zJ6gOB9b97uMpikV73OiQo7V6P1sxUIflZFcYVmlJdOjqdPeqnv3BlKazOzRsl4pelQi67mfJjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGWFhPCNtYF52UVZ8AbRXVmlqr9EI32773o/WxOfxEGoiGBPa
	PrXNANiWWLqWxy3BZa9OCvoYnsEgWsul2dOWr55rFMvw2URDv9+79JRwtQ8XTeZz8PcJAKXxsWa
	sOGORDdI0P7OzpoJJJW+3tO1DabWGHc47EBnU1pq0A9qI+j1Ip5P5H6ZGR5JJ8eJehG36lm4hJL
	E4SJ8JcOw9I3vh65J1o/LvjDfnIo/BhSZ5p9wcpS91wFlVIRQ=
X-Gm-Gg: ASbGncu/L88O9vIpvvrSGN6yl2ULeeBEfUxkn0GKIsraA1vHPr40tq6ZwedlhnoYOhw
	gFogqGKMPN1ceVHxgWdX9B6/buvjCEdl4cwIqrc6Zfy5Pk50URUsq8AYWA6d6Svk=
X-Received: by 2002:a17:907:77c8:b0:aa5:2858:addc with SMTP id a640c23a62f3a-aa580f25c5cmr214945566b.18.1732715444296;
        Wed, 27 Nov 2024 05:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjazrSJpXT3WQtUAce0m6TM358Mro/Sud5IZtPknd3QLTCf4Ede75aPwnsEYPw7KrosjIDGoPFoPt2ry9Xwrs=
X-Received: by 2002:a17:907:77c8:b0:aa5:2858:addc with SMTP id
 a640c23a62f3a-aa580f25c5cmr214944366b.18.1732715443979; Wed, 27 Nov 2024
 05:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127134130.51171-1-tglozar@redhat.com>
In-Reply-To: <20241127134130.51171-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Nov 2024 14:50:33 +0100
Message-ID: <CAP4=nvS0RuUH+RLWHBEQuFh=2-s43vxUw632-i_Lxd6h4+Gd7Q@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/timerlat: Fix histogram ALL for zero samples
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 27. 11. 2024 v 14:42 odes=C3=ADlatel <tglozar@redhat.com> napsal:
>
> Fix the bug by omitting max/min/avg when sample count is zero,
> displaying a dash instead, just like we already do for the individual
> CPUs. The logic is moved into a new function called
> format_summary_value, which is used for both the individual CPUs
> and for the overall summary.
>

Note that the code is still repeated 18 times =3D 3 latencies (user,
thread, irq) times 3 summaries (max, min, avg) * 2 kinds (per-cpu,
overall). Due to the way the storing of the values and the printing is
implemented, it is not straightforward to reduce this code duplicity.
There are 9 different fields: (max, min, avg) * (user, thread, irq) -
of timerlat_hist_cpu, and min/max/avg are grouped together per-CPU.

I will send another patch to remove the duplicity if I get an idea how
to deal with it. The duplicity was there also before and is thus not
in the scope of this fix.

Tomas


