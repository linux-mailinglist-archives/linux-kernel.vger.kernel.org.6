Return-Path: <linux-kernel+bounces-515681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CB5A3679C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6471893B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095E61C861B;
	Fri, 14 Feb 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htnhcFeN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700717E;
	Fri, 14 Feb 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569019; cv=none; b=WQY19768KJIV4ZaXUz2T8l6g5/GCfZqjfrrUg4qttIjK4aCXt4p+2CKbBN/h3J6/5jiIjB9P76HwujShfVwr9xDETY//TZawmmEzOFM3eQpQq04tPb0kKYeCaV+kWOzxcdkpgK2hM8wRfuN9dJBjtt5An3KXmxMrOC8omHs0Xtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569019; c=relaxed/simple;
	bh=SnQf8foKvD8I6yba94kKtPHlpE7Jkb6+41mwfXZKEIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opYwt8mNJsBywWhvwbTq+2X6Qvf6mZxcpeKDrflnvP1mjdNqguq+DOO09XJG5PNT0DCQK5JDjMRxBwsOuDd0EzDPuhur8ZV5wzPIDBjE88j9dx7CRjWw0qq3RQcA0CgLM8UxtGexwmK2DhQptY8PmlEENkUJDjYJVjxeX3NunpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htnhcFeN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5450abbdce0so2687191e87.3;
        Fri, 14 Feb 2025 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569016; x=1740173816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SnQf8foKvD8I6yba94kKtPHlpE7Jkb6+41mwfXZKEIc=;
        b=htnhcFeNOy2H8p7heJ385L10EjxwFpT9KTPDJ9x/qB0dNlv2qZzZE/QIxx2GVUcWfq
         gVk3BM++z+bVyQvx+edvWwA+b8ohW6bafVyuiJmNQvSHWXgZbwbk9pna/iumBinLweMP
         8F+2f6HmxUzt73Hoe+0fX4rIWrEBiuHgNpdzF9ks9Sz/Yw62gB3KH4F7FX7lFAMnUH6N
         +sZIC+jhPOMUR70vwYdWeSoek9RgxHrcI9kjwsq8V10ObHMZKbtfYCoE/cnvYNELoq/T
         r8/iWiA80y4/zKlzfWziT6fRxJ/Wvgcx6PXJG9HX0bAN0sFue/ltOWniFirNoIUIOSZi
         lZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569016; x=1740173816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnQf8foKvD8I6yba94kKtPHlpE7Jkb6+41mwfXZKEIc=;
        b=lVdnSGQ/c+DuXZEuSYdIJ7RBNV9QAG3eep6Lv+4QbyY9pDKxK+d0Mp5g7syJNfCwYZ
         fKeTgDyCC1n46zA/j4zUO+7yjA2Y4iarLQ6FjAUKP2FLuUK5NwtTm1U0SXR7Xhun+mM5
         i8cf+Lqvs3YzCbk3Zn9pl6aWVpaCOiQK80ByOJ0S+lX/3t2n30kYQuFpIqdlQ3VTGKpw
         izOWLQPBsXLJvpUa7mKVCuB3OgS1Dpw69RBnj1A7kTTOAOnZXPJuAmIienS1FjAJcV/0
         YOQcibjQWEgo7kv85LzIOACcTNGaDpywiadGRM1JwTHNEn99S9UhgI5weEqyAo6PjfTD
         6tRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Zd7BW/UNAsoy854dYwgEEWZd+a1mG5jcxOVLPDNLkXt4Tmkz5tYb+I2DuJ8o1qDJeLDRKqBs1Ojg7g==@vger.kernel.org, AJvYcCW/4ndcxNq45PoayOY7l2rxAVkkxyXezV8y5zlS92NKVraZ2209DY26D+Ul2lZwdKti4taeSfFNrC3c7+Rn@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKVHJQbBfyVnz9on4jeSKrYA1YAqLPWJI60ULt9bTyZU8+rtb
	zlDdYdolRvbSluCkVqTd09phUFCyBM3UgwJNoRbv7rmURq4oE4nHoUy2arrb0v9c6rfEy7bM4d8
	caPMHo/aygkVOvRbg+3dXmVN5jGQxgw3x
X-Gm-Gg: ASbGncsaEjAb4kdGyzIokQgep6jF7FD4np5bM143VDR0SNJzZzr/woSJ/uNWu0la03j
	FBUnAxAmvgs4pI3vGaVEpCZ3EScsh8yV9poLtWA52gzrbKMSqjTaWn7wSd6b0xkbuzo/Ddzk=
X-Google-Smtp-Source: AGHT+IFzoowX+0qzWRAqeyxZpxC+64fiapQHcokyXowLghWbeIi7apbulDxYg7/ETOnYQ0PZaiibVL8kVIZzq3O7V44=
X-Received: by 2002:a05:6512:108a:b0:545:441:52d2 with SMTP id
 2adb3069b0e04-5452fe5836emr380059e87.23.1739569015500; Fri, 14 Feb 2025
 13:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
In-Reply-To: <w3rw6n4cbgmlcylf5gbzzocqhyxjoyjy3qiedb7fzvd7jdwgap@44d323cbjljd>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 14 Feb 2025 16:36:43 -0500
X-Gm-Features: AWEUYZlqxfIUQ_BwTucFKH6H9EeGUkxGVRw42TkVJagTqreLLgS2GWG0ar3rdok
Message-ID: <CAEdQ38F6ts1qXj2xb+PN=O_byGwZAp1mvF8aRdTEq2zrzLBFSA@mail.gmail.com>
Subject: Re: [PULL] alpha.git
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

The last time I sent a pull request to Linus he noted that the commits
weren't in linux-next. I meant to sort that out before next time, but
well, better late than never!

Could you please add
https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git
alpha-next to linux-next?

Thanks,
Matt

