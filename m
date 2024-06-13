Return-Path: <linux-kernel+bounces-213715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86983907971
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C34B22C99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F9149DF4;
	Thu, 13 Jun 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jgf3hbn/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8661494D1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298577; cv=none; b=bqYH4xJ8Ov0zck3fqj3VvsfBgbGZm9pZLCKDkIs6a4xW88o2+x+SHw3KrJmEONxePenMeNbXYOp3KtiHA5bcm+4FXEWcCGWnR2CHJdy3REQsHENlxcUN9i7wZ8GbLYgfgxwhSqVvA/NxMNhSLKYKpTRcpek8l5dJr2oAje7fDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298577; c=relaxed/simple;
	bh=dro3L3OTKiADisnYmjVTVIsNtkmJ0Vg0GlldwOjDGkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRMwt8vbKGatuQRIizsY08zcTTebngJGXhYMLPMAIatJFlQh6UPjybiMcm4CNcCa4sujM/VRoSVQmfylmtHfNL1fe6JpSYhkA0JzmbUc1wHh6ce12oUQcfWYhA8DfavTNdmce3h3P4BI+9u1F6UkBrXceH7AgkZGy6yTf8pq3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jgf3hbn/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so1517770a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718298570; x=1718903370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUKnSByiq7IJzswYOJlBbKH9FX6XnqL9Au/j9R0AESA=;
        b=Jgf3hbn/RMiqDr5/467CKsfroUPCQ9VbBnJv3EDMHUroRU6+YhgO8TbFZ2xJqeR29k
         sjbcRFsZzeje5dLJwBPwCEI2sW3RKik4NCTvUhDflynU9pxi+KEteK1Fkw1BHMJ+Ozmy
         yDs8DPrn2iMA6xrzj9zClNpRP25dFmOctbu7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298570; x=1718903370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUKnSByiq7IJzswYOJlBbKH9FX6XnqL9Au/j9R0AESA=;
        b=EUSFaRyUGT/9JjU9yx/cEQu7SLG311gvLrVKPVfEXVpBZD0RU9KG8ZLBKaUogObFNO
         u/TkL6gfdysQYfNJLeZRnnMcK/cZsSdF8wlU22r3BrxB9icpdzjpFP5x5mfpdQncx97N
         hyRCjmJwhQQqWDMkrdvTSUr+l4a6r7uacE1Ll1ogrRjE5gSG3R/hNIEYsQU932Vj0vTX
         dx0jF/grEbzc4u6ZShgqlsi3b8oEHz54+ciUegRWk5me5Y9tgn18o6NxtwIxsVjRG6qk
         ZHgzt8gSCHLRqAsRhrlk0rCXFDVfcXCg8oHQ9CvUGUMXGT5J2kg1t7xiKSs4LcN/TWzK
         Kv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPL996MYlGFHcsMIIOvbUL366/+8brZJLHe7Nrt45Xku2KVsJSIUQlwj+mWWAJWBqNh0Dddyn4R154ytyUvn3SOVGMVaqm5tGOx4La
X-Gm-Message-State: AOJu0YwmtcMGigoZrJrLg464MHNlnEfiIj/J5k5HE+fcSfdM2eAGr3yh
	h2aoo7rTxoQGKRAW2bo8ctqvgAy7oY7aoSNuLFWcfhwr0FRpD8ynow662S+YtQawqs8ldIQeGQU
	psr8IkA==
X-Google-Smtp-Source: AGHT+IG5zlE4nHnYcA+ENDar4kxlWMn0oSs8gG1v/jR+lTLiFD8W1iNz6gPipwsFO5WlD7rVPMhrAA==
X-Received: by 2002:a17:907:10d2:b0:a6f:147f:7d06 with SMTP id a640c23a62f3a-a6f60de642emr21261466b.77.1718298569727;
        Thu, 13 Jun 2024 10:09:29 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db681fsm91343366b.72.2024.06.13.10.09.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:09:29 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f0e153eddso180903466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:09:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxGkGeObaSN0mkM3qniDjefWYgmrhmIqUkdTK20klSaqZrrTH3BQ9Ws9H0fi3uZi9QmHV6rFJchWunPZwqpb77IXGfeyB5lUMll6e7
X-Received: by 2002:a17:906:c7c5:b0:a6e:f645:f595 with SMTP id
 a640c23a62f3a-a6f60d2bcedmr25144366b.32.1718298568691; Thu, 13 Jun 2024
 10:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmr9oBecxdufMTeP@kernel.org>
In-Reply-To: <Zmr9oBecxdufMTeP@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 10:09:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
Message-ID: <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 07:11, Mike Rapoport <rppt@kernel.org> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock

What's going on? This is the second pull request recently that doesn't
actually mention where to pull from.

I can do a "git ls-remote", and I see that you have a tag called
"fixes-2024-06-13" that then points to the commit you mention:

> for you to fetch changes up to 3ac36aa7307363b7247ccb6f6a804e11496b2b36:

but that tag name isn't actually in the pull request.

Is there some broken scripting that people have started using (or have
been using for a while and was recently broken)?

                          Linus

