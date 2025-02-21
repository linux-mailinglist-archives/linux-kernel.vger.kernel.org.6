Return-Path: <linux-kernel+bounces-525191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224DCA3EC33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16E317F24E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C591FBCBF;
	Fri, 21 Feb 2025 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f066jlLS"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA41DC184;
	Fri, 21 Feb 2025 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740115186; cv=none; b=lTJOxST0dccdy8JQdCnM4LCv3umTxw/dgOyTGpZelG5VX0PPYcy/AbV29Wkpklylz7lEGtSpY/B4lnXsuSPyyI/FsCa/JBWborCmqmHUfvqmD+PFUQiUm9ozO7CpLHc+U4E7LHHQnCq42gOBP2Y/+6u1qHxr4OX8g4eh1TTj3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740115186; c=relaxed/simple;
	bh=O8d0sg3OiW0EYlu6tUHyrluwGg3zHX9W1ljOIFTfvP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/X203SpuGuvUIV05F7BPvh0YQD2hapObFmrixsWxAwIqpMK3PsDsiClo9v70uQ5vIJIdvkbYjN/97eQxNrvoWkcODYkyX9OpjiuoF3YSyW5emgkpyKUJ9Y+G13cc7vG8P6slfnFqMnHoMhQT7oI+1Lxwm2PKi0mCjIVdKzEGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f066jlLS; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2adc2b6837eso436948fac.1;
        Thu, 20 Feb 2025 21:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740115183; x=1740719983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7GxnhS9WVFYcGLggu6o4ECrksBl/EI/neRDN6fay0Y=;
        b=f066jlLSNADNGohAqSqkwSGfIpCyUWE8CS9GYAA4chFwLsX9nUCbiDw3nUnwBmXiKD
         +kHCaLLQpW68+JXUAT1EAzo/0ZaTvwB9ZRJDRBlUhFr/ogdZZ5aUlGDp8wB6mmRo4vdH
         2sb79lv1OO4rd6rICmUTFbwBzNFBXs0LAzjK6W6+1j+BdeDguhC+p1JMB49QgPIuOBNJ
         3T2XD9WO1RALHh4EPLz/gYA7CyqC+ySret181CEUzSnC95dyEYAvazY/LNbHPGzmQfZ/
         ptGa/A3geUA4rBfs0p2nbJTNzo/uQ+nYJWI/eIkTvw4ivpcDOM1MHdi2cNMfbrHVxcz7
         XC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740115183; x=1740719983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7GxnhS9WVFYcGLggu6o4ECrksBl/EI/neRDN6fay0Y=;
        b=t/OR0tOIZuOn7n8VfOuZKYeFqZHflbQT5f4lKQuy+j0kIJCsDzzSnLabQkMCNaRhum
         9k45i/TMQo14gJRtU9qElykQNEAp7jaSvS2KUhAeqHbavtCvKVLckbp1v4Pe1XHm9B9I
         CmN49egWuaQjrSECMrJU/to0EsiV6Y2sopMkv2u7TRpx33g/mcd2ogcEvPAZ95g5/c4e
         B9xNDuMz+yXZSNqNpKLd29KBdRGsbt72bK+/EEqjAKWfBJS5bZZT+f8ifrDlFd8BouQx
         pNn5PUZGzq04o5qp52r7sU4/Qqd5vuRGEWjEhC+ZU1r55uW8uuGp6Lcl+9+1rykx5tiu
         at2w==
X-Forwarded-Encrypted: i=1; AJvYcCUGUJtoccm3FtYyoI0pnGa2Q3UF8nPS0eUQRm75Wi1Co9GylICSSocimS0oT7t0qP7GUSvuLPhdNqrvCTx4eY0=@vger.kernel.org, AJvYcCUY1EyrU6w6SuieeLmZwUhR4S3izB8beFMlb0pX0mlyTXYhCCIfOSh5eoT+ey7WbFC5ZTVZZ2YkEiCjfNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykWkVOlDxG8IMAnxchNYDIPpcaQ15mnKdlq8gDvwu5Li9kbg/I
	RIRnOwp8hU8DLaICGvD0Hj3EtQZbG9dzRFiRsVNKlGlqDyH7JNg1
X-Gm-Gg: ASbGncuMWXajy9SDlDuR84lKW0o/HD3Ik6ORnihXJXAO1Pvb+uInJRV9OCKfIH6rYFS
	tn7hRWyh+y2cxJo+VKpUCA5R/FNs+P0XmLA0x2WIkxDTW4yzcEOBeYOysXM9VMAGoWpY9/PdF4T
	b+FrrTNbTlaf1ebXffd6YWH5JV2dITOvYAdu4SVkZGSQOfyNUms5mAtHN4/LSZ2uHOWnnu64gaN
	SHsFh2fEE8P71fGBKdfO1pqhrMtx3bmz8RdBJ9KL4wBwn7c8U8lq23YEVOqrpTXrVyEyRrzJo7p
	LJnByGUeIQ0yIL0M0v3+qsZM44rf2P7djGg=
X-Google-Smtp-Source: AGHT+IGoA6z3KE2h72mJwhh7s7O3jt1mACU41v7uUqoGM/05ZbXw7E/XMUInCarZyEeaGUD9Lfpnrg==
X-Received: by 2002:a05:6870:9613:b0:27d:10f5:347 with SMTP id 586e51a60fabf-2bd50d01beemr1409542fac.15.1740115183524;
        Thu, 20 Feb 2025 21:19:43 -0800 (PST)
Received: from localhost ([2806:230:6026:c0c8:4ae7:daff:fe31:3285])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2bc70042fa9sm6016647fac.43.2025.02.20.21.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 21:19:42 -0800 (PST)
From: Felipe Contreras <felipe.contreras@gmail.com>
To: gregkh@linuxfoundation.org
Cc: airlied@gmail.com,
	boqun.feng@gmail.com,
	hch@infradead.org,
	hpa@zytor.com,
	ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org,
	torvalds@linux-foundation.org,
	Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Rust kernel policy
Date: Thu, 20 Feb 2025 23:19:09 -0600
Message-Id: <20250221051909.37478-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 0.1
In-Reply-To: <2025021954-flaccid-pucker-f7d9@gregkh>
References: <2025021954-flaccid-pucker-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greg KH wrote:
> But for new code / drivers, writing them in rust where these types of
> bugs just can't happen (or happen much much less) is a win for all of
> us, why wouldn't we do this?

*If* they can be written in Rust in the first place. You are skipping that
very important precondition.

> Rust isn't a "silver bullet" that will solve all of our problems, but it
> sure will help in a huge number of places, so for new stuff going
> forward, why wouldn't we want that?

It *might* help in new stuff.

But since when is the Linux kernel development going for what is better on
paper over what is actually the case? This is wishful thinking.

Remember reiser4 and kdbus? Just because it sounds good on paper doesn't
mean that it will work.

> Adding another language really shouldn't be a problem,

That depends on the specifics of the language and how that language is
developed.

And once again: what *should* be the case and what *is* the case are two
very different things.

-- 
Felipe Contreras

