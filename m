Return-Path: <linux-kernel+bounces-205759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574EC8FFFE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28CB283E22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB61411E4;
	Fri,  7 Jun 2024 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FjgWhu+o"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51438F86
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753972; cv=none; b=NQX/5yqQp/TiULbcOw2xwRHB4RQlQLqjVmVf7WClfFGr6slwX8J6j5zV2VTEZYFzVd4haZTj7exf/K4ZF/KlxyJJiyUHYDatOC0R2+fOkvAp/F84MD2QadxDO2sDaS+dZEgwaN4+nOuzkn1r89Y4oXFug6odSM+vEn4wKxnGuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753972; c=relaxed/simple;
	bh=Y9XbEQz5UTpkOCExIuDqh+9S+D4sPrRZ3b+gwDoM7OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id5fJhb6POk6ZnCVc21gH21xhb67iBpQdb8d5w3pd71im9P5lux3IuALUkwNFMTGIVEShakZT7pxupJpflhbQwV0TbGcN/q4CvFoSLeVk+W+pSAC6DC/jtre0Par7LuZl+4SxH9PvnN538H12bippK7KnR2sEnn7o+50KwfWazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=FjgWhu+o; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so22384401fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1717753969; x=1718358769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qR4Iz/w8T5QunVswvB0VhLhJEnk9aSsxgQy1fVCW6zY=;
        b=FjgWhu+ogqZi2e9J2ClBf7BYUZmzhSdO8dz98QAbAmjI7SwLbSh2SGaMjnCWxZhC25
         nLxd7AiXvhia2y5tb9gdcZH/WxEzESV6V0yBWWpf8rGvtxQv93Fhfm1hzRGwbIZtKb7a
         NDDccmsYE4LKVg9HMZabdKsxXsMGekbkXVvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717753969; x=1718358769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qR4Iz/w8T5QunVswvB0VhLhJEnk9aSsxgQy1fVCW6zY=;
        b=NUIQt16bWClY6NPdTUVSjGL9765tt79Iv98/XZErLf4BK0jUeRGLff3/zCm8q6URbq
         LBr3vN4/z75aHp/7KPwZRoKw8HedLmzckCmi4Q/0EKQJ2ZfGmKIQOwj43fCHYJB53Qb+
         T/QwJjixOVPfILPL9uJIq69Ts1imrfRWFSGhOJ5RWZriA3gUb3UAqRXxCQ2VA1yDkTkF
         tIq9d4kSZugeeq6Uu0HjblCXE7xbkCurWjGQkI5xI3/7CMInP5CLMKJTLvqRVVqZs3/4
         2K0HcImR/BIMo3Irux0NJ6W35d7U9eYkd3ajLjVb1Tl1As9dBSiD9ZkCDb0GKiq43+TM
         moiA==
X-Gm-Message-State: AOJu0YxPVFhS3hM/pYQ9zFngDThf/clFu43rNo4WnB1F+1v6raCcmr+F
	CkKfx2KpXwgMikL8F+iB8XnN5VNp0lmhQBRXbr9J9DNIqR4fZ9v0SwL9pFfKaOiXGOcP3n0QhZE
	lG/M=
X-Google-Smtp-Source: AGHT+IERs6KSgT7z06uEjPl8AgzdUOOKwkk2FvYV+EFXZSVDeRUsuOrDBm2bg2qysEVl83IcDe8hqg==
X-Received: by 2002:a2e:880e:0:b0:2ea:e2d2:61ff with SMTP id 38308e7fff4ca-2eae2d26485mr6110301fa.23.1717753968678;
        Fri, 07 Jun 2024 02:52:48 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b095fsm4822041fa.93.2024.06.07.02.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:52:48 -0700 (PDT)
Message-ID: <28c74739-e775-4813-b2f1-b588e14b3674@rasmusvillemoes.dk>
Date: Fri, 7 Jun 2024 11:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: objtool query: section start/end symbols?
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 20.42, Linus Torvalds wrote:
> So this is related to my currently very ugly hack at
> 
>    https://lore.kernel.org/all/CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com/
> 
> where I'm trying to do "runtime constants". 

FWIW, I did a POC some years ago but either never managed to send it, or
never got a response. It did boot in virtme and I managed to get gdb to
do disassembly to show that the dentry hash lookup did become a 'shift
immediate'.

https://github.com/Villemoes/linux/tree/rai

IIRC, I didn't bother with updating users when the boottime value was
settled, but just had a single at-the-end-of-init call to update all
sites; in the meantime, use sites were implemented as a jump to a piece
of code that did the dynamic load of the constants.

Rasmus


