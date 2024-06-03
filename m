Return-Path: <linux-kernel+bounces-199432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912108D871F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F002840E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C5136660;
	Mon,  3 Jun 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE2p4wCx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33703135A7F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431773; cv=none; b=l6GKcqLVxPGANR7DzaWvo+l1YYgdIbTray6V62A/5PutE79Kc4/ZRGEDpEICaEd5x0D5ymxUTkFDWDHCIc9z6duakK3y27ssS/YCIhwKK9rYNBcy63iBw/j7ESEl3O+DH4iHn4X+g6O/vL5pb9aSMgU86GsxVygs3iLattO/wJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431773; c=relaxed/simple;
	bh=/OvWAYH0P6ogYo10xALQ7QIqAZoR01AAJjOIOUVXozM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJcMB3TxJa+sLihT6r3AgUcLwKhA5c9T7M922J7qeJhaI9fzlJZ3pQJrkjZ4INNQVFr+0yFlaRWkBClgE1QIZTXS/kOvT0rMp0ZLLwM/+aEa6HcM8IVmQ4e1Ynen4FjRYlpNkV6NDL9DZ2MKmycuflucfMXRzwXGr8HKBkWqo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE2p4wCx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717431771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OvWAYH0P6ogYo10xALQ7QIqAZoR01AAJjOIOUVXozM=;
	b=LE2p4wCx9y3jStXO83M574/ejKft2cx9G+k6mAlEIp36LnkXmIEqDpitDggkZjq7OMlMki
	6azsjFUX+JZ4c0QW3ZhHqxe6wi6mea3SBkWzSRiFanOHn50z1c6N/I+hlROD9FNW3eP8MX
	qHCyUrufBGURdvQtU9CCnGGGbN0qdCU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-03Fjhcy-M2eSd86ybFd_lA-1; Mon, 03 Jun 2024 12:22:49 -0400
X-MC-Unique: 03Fjhcy-M2eSd86ybFd_lA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d1d364062dso4528784b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431769; x=1718036569;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OvWAYH0P6ogYo10xALQ7QIqAZoR01AAJjOIOUVXozM=;
        b=YrCLv6tAUmOWj101cUHj4vE5Il75TbD2eFsEhRme0vzo6Rig2GcxILuKs+vbk02WMn
         BUSkR6d/jBAczSbcsL7Nt2dWCHErw8gV3NGjbj4OtPoBwWvFqY+8Vxs439rOBg4YmHb1
         8ccvb+DWduAs5PLwzwenkY4IlqqtBx1BW8dc7NXwscOOeK5WcPM8W3+5g0eg3C2vuoH1
         7mQx5c9ojo4D8OpqRVftZtYnRZ5Wo1ty6VNk6ixUG59WSOLlAVe/7a+jIdaU5+FXBM7R
         F6rk1u9Yil8dJQWVEx2ZkvaXDzqkZtZSisdTUQ+dCANzwBsmGXXyLDrA5DnTOFZKDcAR
         yzXg==
X-Forwarded-Encrypted: i=1; AJvYcCX38U9N6cXdyRa0yDgvKBv6BqwAWM0rOl17hjn9NU3Cux0QbIvjEOXJLCg3G1W2G5QN+gEwebbx1ARZBavX2fsB4cyoqmGVMChtrD45
X-Gm-Message-State: AOJu0Yw2Yi9S+g65GT3sqgnIPeQIl4/kpYktXjqGNhfzJ+40SioNQnSV
	KKo6kacoklQ/nQ2aYI0OCeHub23wtqCIl68SXBEyILCOh3CpONs3MawCj4a8Q/KXtl5/CwMYDc2
	3GAS9ufgZ5JScCjkgbb9ExyvoBwYpWoBc1rnigPgLsOs3fkcy4ydodgu+nNQ3ObocjgdWag==
X-Received: by 2002:aca:2403:0:b0:3ca:babd:76b3 with SMTP id 5614622812f47-3d1e3480ad6mr8825718b6e.12.1717431767335;
        Mon, 03 Jun 2024 09:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkujB40JEGLJSPMS+fMp8vyiKXzC2SKC+YUf1vVWP9Xydkf1K8gO5okq9R6izLX6WhDGmLmw==
X-Received: by 2002:aca:2403:0:b0:3ca:babd:76b3 with SMTP id 5614622812f47-3d1e3480ad6mr8825619b6e.12.1717431765478;
        Mon, 03 Jun 2024 09:22:45 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c4c:a000:270f:2a70:881d:60b9? ([2600:4040:5c4c:a000:270f:2a70:881d:60b9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a750441sm32138096d6.71.2024.06.03.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:22:44 -0700 (PDT)
Message-ID: <0533e9a6d05b10a00c760142cf268cfd5db0d52f.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Mon, 03 Jun 2024 12:22:25 -0400
In-Reply-To: <87ttiha77b.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
	 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
	 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
	 <87jzjxn6s5.ffs@tglx>
	 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
	 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
	 <87bk58n6le.ffs@tglx>
	 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
	 <87wmntkhak.ffs@tglx>
	 <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
	 <874japh4ww.ffs@tglx> <87sey8g5z6.ffs@tglx> <87ttiha77b.ffs@tglx>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ah whoops! Sorry I totally missed this question, thank you for poking
again
I'm not sure it is but I will double check tomorrow and let you know.

On Wed, 2024-05-29 at 00:43 +0200, Thomas Gleixner wrote:
> Lyude!
>=20
> On Thu, May 23 2024 at 12:47, Thomas Gleixner wrote:
> > Something I wanted to ask before. Is the BIOS of that machine up to
> > date?
>=20
> Any update on this? I really don't want to add magic workarounds if
> there is a BIOS update which fixes it.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


