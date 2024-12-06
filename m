Return-Path: <linux-kernel+bounces-435309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9089E75F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B44B18879F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99751154BF5;
	Fri,  6 Dec 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de0WG+/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D61F3D22
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502624; cv=none; b=iaFtSgf5+EJeMIXhLHwqL4GfppHtLWJ76xMOq6MxC2BbRu9DHKDvHZtZkCtp6Cr2nn9vs3UTezLQqWv+EAyyedDqdDJjlkjrkzlkq/A8h0Ar4kKwLu6K+j0bN0CUkELAbFtjHUhG5LUlXcr42CZ8RU7cQDS3Ls5g5KP0XEu2I2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502624; c=relaxed/simple;
	bh=pQDcAemzbapVktoDIQ8F+y8f6yJAP7/ljBhUs7YNQa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkyMBdwgEW9/vutBk9e3OFOptuuX31VGW+rdHjSaGA2WP5NVxh6abg4HQgYFBdJqb/LDKYcfHN9/b48yObbL4v6I0KVFLlpnuRUQpQ8f2nOOW9UtrR0yYrtfC4O90B75R91SfcH9oUBQX9J0AHfrFbm61ei9Ext8N95mdb4Qneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de0WG+/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733502620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEOV8AIhBoB9AvDjHDWD9/oHVbE7APb5kRg3pvXByF4=;
	b=de0WG+/IMy65RzNlPfDyxhfKZ+v0cWBR8LVeZ9Z1dGsolQtzmyHkv5kA37e92WaW3ypIW1
	3hGR+quYRnPHn/p3OmLhN3Lb4mQSPh4RpHmTofTbXAWb5EBo8GV3A8dwQuDh3n0ULMIwtD
	dpytFv9J1AVFuKCT3vFlMfy+5llcPGY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-EXVtQOgZPR6Gy5-OrhLjyA-1; Fri, 06 Dec 2024 11:30:19 -0500
X-MC-Unique: EXVtQOgZPR6Gy5-OrhLjyA-1
X-Mimecast-MFC-AGG-ID: EXVtQOgZPR6Gy5-OrhLjyA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d0582ad3so1807292f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502618; x=1734107418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEOV8AIhBoB9AvDjHDWD9/oHVbE7APb5kRg3pvXByF4=;
        b=eE/WYlp+9rRnhNlZwhsSuwfHAEDy/9P+LE1pvGNjU/BH1w5052nJhOgGluHcd3eNK3
         5ALdHr3AuTYVIBko0wG6InhAHRgHVPb5dFwUUQxC6Jozf0rg1PvCSCmKbI5weG6hgcoG
         LKAjLtCF0TJiSjeJPN23lwfTfjzicrOStRjQBcPOh4xTBx8wH6qrIlDdQKOJ1VlfaB9e
         aStRdiLpgRA6tIO/xD0fTVKuHToqcb3dVagY6kdquxAYEgEU63PXq1bi5cHRdD+BoTEG
         qyPuysxNTq1f4A9krQ9RbhCwF8aTJWuBwVlJOxPTEjXOtl7RuKxs0CgLaV9I7sq7orJp
         NsRw==
X-Forwarded-Encrypted: i=1; AJvYcCWL99AnYv8WeE4Cq8YJJJyFVyiNDstfQeW0LqbrkdoEgvtx1OAW+nCetbmsBK41ExduFs/FUnuO9jJEIok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuI+tzu0oxXshurhiUpf0+3vsUlEnXEKqRtxX2LR37emPsvnj
	pTNq45IueOrbB6LerRrc9m4eAGA82IsgJtbG0mM4Tee8z+qMcLZehUszage00V7h18e8d2JdCeg
	kK5Pwh0GIbtp8h//i15QhkyL+VnR9H7hHLOBKQrE6UV9xauWuVWkvxArU8sGMQNkVCdBDAId8UE
	Dg2ADTgI96MFPMcQgi3cZn0NEUkRdBqllBW9r2
X-Gm-Gg: ASbGncuYGky8R7m2SgH9bdnsHi4wjQyekzGdbzVVMDhd9ON/+U/aVr2uZcNh+M3xU4I
	Zt9h0c8fbe7uiJw28nia9RsNwE6MMHA==
X-Received: by 2002:a05:6000:707:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-3862b36ace8mr3693660f8f.26.1733502618224;
        Fri, 06 Dec 2024 08:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnu5uzpkWjfcU4pdd5o/39FM3VzHRtGNeapFyBsxD9aw6AxhlBO3YvriAgO37aghT0D8M5/rerbo71B/wuZLk=
X-Received: by 2002:a05:6000:707:b0:385:eb7c:5d0f with SMTP id
 ffacd0b85a97d-3862b36ace8mr3693633f8f.26.1733502617936; Fri, 06 Dec 2024
 08:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203094009.67697-1-ende.tan@starfivetech.com>
 <20241203103611._nfkyEXJ@linutronix.de> <NTZPR01MB10187B77E803325E8C88F383F837A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
 <20241205080614.y_512eFh@linutronix.de>
In-Reply-To: <20241205080614.y_512eFh@linutronix.de>
From: Clark Williams <williams@redhat.com>
Date: Fri, 6 Dec 2024 16:30:06 +0000
Message-ID: <CAMLffL8BPgObXvb4Ps2AkfQj=h62UJ_g_M9OYOkUsXhUZMzz=A@mail.gmail.com>
Subject: Re: RE: [RT,1/1] tty/serial/sifive: Make the locking RT aware
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: EnDe Tan <ende.tan@starfivetech.com>, stable-rt@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	"endeneer@gmail.com" <endeneer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes, I'll put it in my pending RC

On Thu, Dec 5, 2024 at 8:06=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-12-04 15:24:38 [+0000], EnDe Tan wrote:
> > > -----Original Message-----
> > > You need to state which kernel this needs to be applied to.
> > > The change you looking for is
> > >     32c694ec3efc2 ("serial: sifive: Use uart_prepare_sysrq_char() to
> > > handle sysrq.")
> >
> > Thanks for pointing this out, I overlooked the commit in the mainline k=
ernel.
> > BTW, the commit is not in v6.6.63-rt46-rebase.
>
> Indeed. Clark, could you please backport
>         32c694ec3efc2 serial: sifive: Use uart_prepare_sysrq_char() to ha=
ndle sysrq.
>
> for v6.6-RT?
>
> Sebastian
>


