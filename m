Return-Path: <linux-kernel+bounces-442993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB09EE51E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC61882B75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED520E02D;
	Thu, 12 Dec 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KtjiDI7x"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498D290F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003237; cv=none; b=iCUCimlFqTbQ3HxQLY4SWh/7sNQ/k95ngNlwf89PzUYqTjdKEBmn5UEqJ5hGicxwVqlUW27ydeS149AxmEjixLj6/FsOxpU4SKhTGbGhQUUeIJyUr3PFaycS5K89zf4kWNTpQK+GYfYkFSmGE/YANIveVurXo7Ih/9lClOovoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003237; c=relaxed/simple;
	bh=91+dpsPaq5HiwyO4k2+7eVYB1rYFtKtAQnAmwU9oq3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1IO/b/p7kpTGjY1GMw69mSSMUxXgyu4lhtT+q3oVujX0FQnMhZNZuU52nJOWPEuFHNP4drpgpN7qCzzGbqk4GwsorXoPMc+Jx7KRGN6ijGDRaZUoHTWxlB0FYoqkJ8+VBRfVzfmBZLvPctgAz2+6/Trw3dgIrn0sF6m8inuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KtjiDI7x; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so95238566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734003234; x=1734608034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rl2J1ho5fwgD5s/5gtXD4zaDf9oWY8gW6SycipUXCsg=;
        b=KtjiDI7xt5TzsfAO2CRRPmG1gqvW5mbTTL6QebF8QF2bub+VjEQwdbdjtrYk/z+x2w
         XT8Sp4MPxEvOzitVtqa6ZVgOBt5VpyHGTaPpuf7ykxAtRWxdujFciPhzxZs12vewwT3s
         yU3fQlJxwp3kwL3t3AhWJSanHi+hhTpQbmvtYfQZ26Dy41JrX9rUnn5g4gID+gTOvhDy
         bFVi4uG8/SIQAHEZtaRRysZBfJCsjnXS/QxHsVqL51MGGSvufdKzDI+mMhtd2qr6MUcg
         rTikqrPR5PvfCC5jPFaZGjZqHpbnHI/CIqBSQYTwJAkPIopk4c/gl7FMoinhytN6Foji
         eeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003234; x=1734608034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2J1ho5fwgD5s/5gtXD4zaDf9oWY8gW6SycipUXCsg=;
        b=SMIHAugftyv17+ds+Pn6wJ8J0GJa0rpJOioUuFkZhFfzAqnt4SxFvRnTA8kOb5lTnO
         tMtaAWv+425Hpo4RopEyEmmIFpmJEpPH7KgwElfa5RLZE35OVPtvwPTus8CFhWi+CgtQ
         QzIvr6Is2hRJDZ9zmwok6584uUP+u+J+8S0f7YX7GdFMuQHfFVffINHLam4PEBi3NH6d
         1+mUM0A70pl4Yx6sNDV+zu0dbWHv8UXHAgRgiihj8T25sVfQNa5bkYAiVOSukTNcjJ9L
         BRtNvfyRyu0HQ4Mcx5E7KMY3gA880cujUDdxTiRnx4wciqplhY7a/TK6lhmnkshuNm6Y
         Qj/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJlbWvGtWxaMN+ToZ93RgmNO9++ttiJJMEToRUjU/fj7oGxp7DPwfeCiR7Bjc58N2JH4Nb61agEnIWJqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Vjj21iXtOxy3RAsmGv8bJLzvl/gtWg0/Xwz6CLeO2OF+wOYO
	3hPMAOZUkmIZ6REnXEOXcofSisQarW8Lj2KBLDjWPGGM6Irqxe+w1IGUOU0kYIg=
X-Gm-Gg: ASbGncup7+n60N83j1zlrfK/k/I1xxf5vwn9KC6ASInsjA3gTzUWmc0aOKB6b2sAe53
	3ZpECaCD7jV4DLL/IrT3McI6cEzzbvzTUKcupac8f2X1q+A1LRdT/nQt2JrBr2mPyMiw3eSAzy1
	Tu0HzibwRU+wWlcuHd02hLQw7bWgkn7GH8bt+n5CgLjRYIL35uQeh3DeIVBfSycYMSJ/KmaSF/V
	WRzJeZTopeB2W1M0puGiV1ggyt4pyMBB+bR8i+hMfYLgozIqwYT21C0ag==
X-Google-Smtp-Source: AGHT+IHXMDeLuKRB7Q7zD6bExN76z/EQS2wssQA5KyO15C/OVpodhguwh1+3iDzwoMw3oEQXpgrUPw==
X-Received: by 2002:a17:906:1ba2:b0:aa6:63e2:535c with SMTP id a640c23a62f3a-aa6b11e7f6emr609761166b.28.1734003234448;
        Thu, 12 Dec 2024 03:33:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6996487aesm470726166b.12.2024.12.12.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:33:54 -0800 (PST)
Date: Thu, 12 Dec 2024 12:33:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Fix signed integer overflow when defining
 LOG_BUF_LEN_MAX
Message-ID: <Z1rKH8--kHA6vwp3@pathway.suse.cz>
References: <20240928113608.1438087-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928113608.1438087-1-visitorckw@gmail.com>

On Sat 2024-09-28 19:36:08, Kuan-Wei Chiu wrote:
> Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
> leads to undefined behavior. To prevent this, cast 1 to u32 before
> performing the shift, ensuring well-defined behavior.
> 
> This change explicitly avoids any potential overflow by ensuring that
> the shift occurs on an unsigned 32-bit integer.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

JFYI, the patch has been committed into printk/linux.git, branch
for-6.14.

Best Regards,
Petr

PS: I am terribly sorry for missing the merge window for 6.13.
    The patch went away from my radar and I have somehow missed
    even your reminder /o\

