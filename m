Return-Path: <linux-kernel+bounces-417552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483D9D558D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F3B282A54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688B1D932F;
	Thu, 21 Nov 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b2U02m6+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC2200A3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228718; cv=none; b=aHulQe1SAQiVb1Bj67QccEloV/1qLyhv6m92s8vMeG5WBoqHupAFO93hyig3xX2u885sE+nwBmgHhWbU15rPohMaNd2XqDoUqqiEoQ2tB1IfnsH/z33vh92cH4ULIT020fZw5n7aBvCXYipb1tJ1OV2RjMmDN4JCnFkT11C7wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228718; c=relaxed/simple;
	bh=CSchTMooglpmi7tB+s7YZ1HskBoi6MQIVMFny/q7Vzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nrv/T+MQ5t594aN0Ad/WxoE3Lgi9TVHhjt22zXzQe2q5KH5OAD8pVrrP9z92Wdqj2aGzJoJTS3sK6EfoL8RTjcZc3xDDZyn4QRYMD5l7u0tW6DSjCpgMxOdg5nQN2O+r3lDYVcbtUxmEEGC0rQpOeg7Lt954Nbf8NDxKKRnIC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b2U02m6+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da353eb2eso2479493e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732228714; x=1732833514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ8nXox9oTtbjG8THkz1b6EX661ulPLtJl3BXlJ60G0=;
        b=b2U02m6+5Z5URUjgG1H70e4loaskxxSBCSlcnnNqbIS84Aj26UgcTY/n1T9pcPruhd
         sugGztIrMP/1QY+8VQpmnjX8FtcgmpOB81VxIK5eKFnJUXcIKOApF6mA/FfWrRc83RNB
         u3I81fyfT7Pyfq02fNArixVNq44ArrIzQ+VKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228714; x=1732833514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ8nXox9oTtbjG8THkz1b6EX661ulPLtJl3BXlJ60G0=;
        b=cQtOxCSRW1WmJFfI/70D0uhpAafXITRDqYKLIHuok7rjTZteOM1JlPJ8WO8OpVLO9j
         wfcCMgIIItYdYll6fuWXxN7nx4sUM5wiYgr/1y/7x1VK+xOgIH1gB7QCD5QiIYE/zvPd
         jAgb3oD79hUdsTm6IFOcuN5bVrehh7xa+qn+MfmuQjfO3uSqT+6WEiuUw+cWC3cnw07L
         jpkrp7wS+dA602vWZS0eZs/70JHI4fEFJXWreBy3jSyIQPqcMqssgZ3j+Ib1sebPEoiq
         v+pgpL6T/qJ6A2mWo2xtVSBXcXEv/I/FoV1xD5uTJ/wu6liQsXaAWkx/JWF4mIHIIrom
         2T/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsMHz9UgY1NOfDB4l46Htt0YMwfqJzEuPNSUbdAnkfunHsZ/rH5TeIMVGN/9klT/CO08mtttICpzljzes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWU0C5mRIDUinzuKFpi1NooIJz/guctb10L+g5KQY+YYtVUfdp
	WR9iA6EbSRNf8HAuMTniHr/8QZJPYVDPINk9uz8+3BsjgghQlUdse/NF+Izg3msCkFn6EiDQn1b
	FND1W+A==
X-Gm-Gg: ASbGncv0kPadjx/5NRNzRxd7gnQamgf9Z9DdsT0n6Gfs+eA2vMtujyyF/nj5jlOG5kG
	iDuGKPwOYi9pqfiqEE9R4BuXB9hWLRRgDXVc9xnvRc5K8joKG7IuZYkwZztZaOQsmlFIYhl1pXr
	RSwFB1GwOEeVsqxlka6yhPbtUDekhxaTVJU06uG64oyPCxfGdEOJMClCcR2hRtexAVUScke/7dw
	K17HRk0pD4fGoNyAv41h7pl7Z7RlSfxTqJhJye5zVidWTSwiMLEpc0ZvE9tGij3bSNUbwXNIKza
	4gbUFeJSCkPq1IicZSjNa0yQ
X-Google-Smtp-Source: AGHT+IEaA0+8/r7QO2CfkRQ1fZcc7GtHOX+ykpssN0vqjTzX/5wsvlibACkSJ5iTSqgIMjkkBh2jMQ==
X-Received: by 2002:a05:6512:2316:b0:53d:a866:9c42 with SMTP id 2adb3069b0e04-53dd389cb4cmr334265e87.30.1732228714068;
        Thu, 21 Nov 2024 14:38:34 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c98sm20273366b.183.2024.11.21.14.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 14:38:32 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38245e072e8so1349413f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:38:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSOcdGyEBvr12JnbtXjR7d/z5W8I3X1Woo0UDzLdnsdS4M/C2Ix8v+AFg1JrHPm0VOYj/bjkjfogs8Li8=@vger.kernel.org
X-Received: by 2002:a5d:47cd:0:b0:382:4be3:b2bf with SMTP id
 ffacd0b85a97d-38260bc6bdamr675542f8f.45.1732228712281; Thu, 21 Nov 2024
 14:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411190900.FE40FA5@keescook> <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org> <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl> <CAHk-=wiJZDxO+Wgmg8f=Cio9AgmJ85V7do4kxroKejHNsS80hQ@mail.gmail.com>
 <Zz91LyHzxxOLEma_@kawka3.in.waw.pl> <CAHk-=whv4q-RBXmc9G7NZ4GiATqE_ORU05f=9g00HkQXbV7vqw@mail.gmail.com>
 <202411211011.C2E3ABEAB@keescook> <CAHk-=wgfX4dvvKo8PrPZj76Z2ULMMK2RvaF+O7QhLnwOSBYdhQ@mail.gmail.com>
 <202411211302.08EEE6D395@keescook>
In-Reply-To: <202411211302.08EEE6D395@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 14:38:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjRE5S_vpQdRH-ZH2Q6SU1cmX0HhwzmfpjgYtoQAtok=Q@mail.gmail.com>
Message-ID: <CAHk-=wjRE5S_vpQdRH-ZH2Q6SU1cmX0HhwzmfpjgYtoQAtok=Q@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Nir Lichtman <nir@lichtman.org>, syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, 
	Tycho Andersen <tandersen@netflix.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 14:06, Kees Cook <kees@kernel.org> wrote:
>
> I think I finally figured out why you keep saying this. I think you mean
> to imply "ps -e" (or similar), not "ps". Asking for more process details
> ("ps a", "ps -f", "ps -e", etc) uses cmdline.

Ah. I never use plain 'ps'. The output is too useless.

> Since comm is mutable anyway, I feel like the "friendlier" default for
> userspace would be option 2.

The thing is, I still violently disagree.

I don't see what's "friendlier" in being (a) slower and (b) giving the
wrong output.

argv[0] isn't what we *normally* use.

And I've seen lots of cases where argv[0] is actually plain made-up garbage.

Christ, I went and looked at OUR OWN TEST-CASES, and they just happily
lie about "argv[0]".

Just go check tools/testing/selftests/exec/execveat.c, and see.

So  no. THERE IS NO WAY I WILL ACCEPT THE GARBAGE THAT IS ARGV[0].

What is so hard to understand about the fact that argv[0] has never
*EVER* been meaningful? We're not making it so now.

            Linus

