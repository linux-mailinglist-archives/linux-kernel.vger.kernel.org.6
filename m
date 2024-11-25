Return-Path: <linux-kernel+bounces-421729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68479D8F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C3168F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CAA195FE3;
	Mon, 25 Nov 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MWK10U9L"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DE1946C3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578045; cv=none; b=LxSpOvJTehNB8nQhe01KGGRQUGreJ3HZDnVzUHVr47THjI46GReiz2GxhQIKjriyM6ZKi8moHJMr4ZNP65/d/NHmOFA1oRM4uEgxvaxevO7L7XaaBu1i4SIMXCgDtEkMEAr1LvhyTkvYuL3qcAHk+vQlXullq//gxZhdb/MUM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578045; c=relaxed/simple;
	bh=yqQVvq8lTMFOR8WCOuWvtJi0k78O9tLZ+qeTmTRIjWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRjCHanDcW5xdjMItvtua/SUWv6FQRGBnRF3QjtvCfU7J64thMo9XKGahH+lR6yAk6+SsB1M2/1l1gb+VzL/DaIp4mRDxaQ85GVN/aQTsZAb07O3tCOI2KfSC/iEU5rhK/FMf/6iyEvmBk9oJK9Y/hxuWHeSnQS+R1O7UpBpcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MWK10U9L; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso6266332a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732578042; x=1733182842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RlY2ZMrYaHz582xTT+rxAcAIIF8NSzQOVmJaoBAXy8=;
        b=MWK10U9Leb/CPT5z9mcQXhekcSooaq09nYLciqyj5BfP8kf3u2Ny20a3QUjKKyk12g
         FnOm58HPYZ7qrefQd78/33ojSGFIYXM3ifQUsVMvgbMYAfLMendVrglxmaMNrbwoEtoG
         W5RTon32iqWOdmSNSrB3ttsB8hw54oUFiWXNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732578042; x=1733182842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RlY2ZMrYaHz582xTT+rxAcAIIF8NSzQOVmJaoBAXy8=;
        b=Xl+MNR0ds041wTpgwtEuv4ojsEP9pgUewykBQca9uZOMESvSAwnz0c7uOBh4H91Inl
         19rk2NyjdxFYazfAbG1gPmMxDd8t7Kog1HWCNLTkQG2Siez7Qdody4t+aMLK5qsh+0rp
         6UBA8NNNbM2v7ebXSdclYu1qiP7X8mAKHuDPN9qKuIoIFfPOmO2ybFRRDHa6boIn8IIa
         xjDVZ/g42KVDWb5TYX89uMQADDhUL5Bc6IPEzzJxppEpbOCOYBcPEwkkLlU2uV9N+VX9
         fp8LbpvfjqDZLoDbVTCfLt7xGoRmkxHOoZn96MeddNjfiWh4awgKI0oj+lOfJGfFvvjS
         NcLA==
X-Gm-Message-State: AOJu0YzWW2Y8KwIPYbcENaHHVppOUGz0m6eDWv7z2CjWTksklAw6LAj3
	mI2erwQdae0HNdwNQkOjPOmrxswN+1Ip+tjMIsVIENAfQIgJebjRdgqTZ+VBXWbgcKksmK+avW+
	q68g84w==
X-Gm-Gg: ASbGnctM//RBFJpG5yli/zTIs+pQSPY8hx/VS396eRyw1Zm1/ahtrYJvaxbQV/fbbR8
	zmIKsKgofnRgtagBkwDKhU8OUr/L4KAz6SeR2mG5Bz67PK+4OVV7Tsr/JfPqrsZYbcai0AjS8+G
	9vBjgk+IoczmZXXIp+mu7gm9RF8YwJzg4N/kbFMBRDpufx1NxzxuEo9pLxGzwUqfnqMEYwbfnYp
	SK8JtzGwefIhhWK/atUGnzmp0XTM5DATEWQ91I1TsSixLLAxENCL3MSQfqXOtV37aDEvqPt40qo
	QC1cG+DQSaO13Ix0gCwURtlp
X-Google-Smtp-Source: AGHT+IHlkDIx79pdZ3NEFU3tIxZbJB0dP3B14Bb75JveeeWKxW87NZIAKIqdwf7/eruxQT6eYedlVg==
X-Received: by 2002:a17:906:b3a5:b0:aa2:c98:a078 with SMTP id a640c23a62f3a-aa50a08cee0mr1158916866b.57.1732578041787;
        Mon, 25 Nov 2024 15:40:41 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa549a5fe40sm251806766b.134.2024.11.25.15.40.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 15:40:40 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so519229666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:40:39 -0800 (PST)
X-Received: by 2002:a17:907:7795:b0:aa5:31e7:96a with SMTP id
 a640c23a62f3a-aa531e75d44mr806950466b.32.1732578039007; Mon, 25 Nov 2024
 15:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook>
In-Reply-To: <202411210651.CD8B5A3B98@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 15:40:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
Message-ID: <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 06:53, Kees Cook <kees@kernel.org> wrote:
>
> Please pull these execve updates for v6.13-rc1 (take 2). I've dropped
> the argv[0] vs "comm" setting patches. We'll work on the better solution
> for the next merge window.

Yeah, I was pulling this, and then noted that the selftest is now
documented to be that garbage.

So I unpulled again.

           Linus

