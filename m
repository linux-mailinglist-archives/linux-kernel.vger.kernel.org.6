Return-Path: <linux-kernel+bounces-367833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314B9A074E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E691C25B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF5208D60;
	Wed, 16 Oct 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ciwYdosW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73E208989
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074280; cv=none; b=Nt0gzfjGW3yD9z0qe2BbKFMI1oR50J30UV2m53KY/QKjHw840NEU6IFTToTrQ14S2x0jZFBdhkeuny6Ilaoe4g7ZCHfyBXs6LS+bDoPLn1pBQ5SkycrAKJUG1xUHx8fgJpwaaRB28WPRsp7sy186cyoGAoJFRHSgIEVuoPvLjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074280; c=relaxed/simple;
	bh=rd8lV8xcyybj14ozti1TTWcm7mZH/T9eRtu97bQ2Y9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrOehaM3B8r+iJNudXNCxESp7DIZO71HV052+LBRuePqwZSouzYjllVQ6Ms2Sk7A3qJCXbs7MiOYSyYH+N7qqtMXLSOMlao3Ky9H9UmVrDQW3ITwR9YXleqNQrdwFmjkwj4XJAwiGltPS6YgeVvho+0sCokY9557CeyrQeycF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ciwYdosW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so3835710f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729074277; x=1729679077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7D7ZvOJaezogmPTDAjDT9QfTx99YDW2toHDAD7luHo=;
        b=ciwYdosWe474FGjpzYObLD3LYsW9pObj1L+8+V65egzeD40Kp49em5SzMg7wrYbIt5
         +IayKpWRNnonE/l4bx4xrzYfGNw6Q4lrltEjpuLmeqabXYoPPHP6kH2lXYbKF3G42afU
         kVDF2NujmvcFA7CO8dSzgaEp+/LmOchyFQ/qKuXeR4bz36fwLnspJSwuex1R03iqFdXw
         HW6VMTd8BgOaRvERmULAFhvLgRvU0qd8z9dU92QjtOobMWzdKQSgMqpjTUmfSYD2VkCn
         WiEj3lL5Grq+pNcJec1oOGsXgesuYToDWhyg5Mu2ESnvkKPYCV0tSLbjeXVmTJFm2/Se
         ArKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074277; x=1729679077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7D7ZvOJaezogmPTDAjDT9QfTx99YDW2toHDAD7luHo=;
        b=TmetplPjAudzHIThY5jE4/oyTXsxdfM3aDGi9Xw8tXamWrlGNrswYRVKLvNfcjqXAv
         a33Bc58ZPbei87E4SpXxkXCL7v7eWTcryfrUbcUhqd1t/tGyBLEGOnbP82de6iVusv0w
         zF3GIx6GBoSQtyNHQflrZBiXOzZV6aWviO7+SxgX7ltODUnGyJg3yPIhEJvAhjuBd9zc
         XR9vLP0jS1uxRofoSY0v66bJQlQl/iQTVma5jssx+iLoNbUbKgKCOu7g2rvGuTq6uXBS
         fOBRCA6Gug3GH8Wl2ymuHWDURVd7j8CJkGJpVOo6GPsJpN6R1tFAkCl2j8cef6SoWFou
         1izA==
X-Forwarded-Encrypted: i=1; AJvYcCV/LyvovZb1gr6NeX75+xq9XPTykxKP0jjMgAlQg4HNisgD9op+6AiuMq6YwgHwSB4CddGuMgAHMnxgbuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+ajOq1sqFz/faUoaS8NnkW9y7lsHoAgXlOiF9bI8a9UrPrtk
	ipNuL/1duiqyNGumE5UXmAC1e+NeF02L/YK216htwb0UwXW9PhSYPITiA0WLUW8=
X-Google-Smtp-Source: AGHT+IECfAeDsAHx70YRZ+3//F9leahyUqpv+lP8UUeInzpfWQ7trt68orsQg6DrKKWRbQoo9ssGvg==
X-Received: by 2002:adf:fcd1:0:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-37d5fd4603bmr10330076f8f.0.1729074276968;
        Wed, 16 Oct 2024 03:24:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa92741sm3956872f8f.60.2024.10.16.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:24:36 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:24:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <Zw-USn7PUHwCIGfL@pathway.suse.cz>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
 <Zv2LQLsIC1y0bCDL@google.com>
 <Zw5ke11y4TkRQJQ2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5ke11y4TkRQJQ2@google.com>

On Tue 2024-10-15 05:47:55, Isaac Manjarres wrote:
> On Wed, Oct 02, 2024 at 11:04:48AM -0700, Isaac Manjarres wrote:
> > On Tue, Oct 01, 2024 at 05:46:31PM +0200, Petr Mladek wrote:
> > > On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> > > > With the new logs, it is much easier to see exactly why the memory
> > > > increased by 2304 KB:
> > > > 
> > > Note need to send v3. I could update the commit message when committing
> > > the patch.
> 
> I just wanted to follow up to see if there was anything else left
> for this patch? Otherwise, would it be possible to please merge this?

I am sorry for the delay and thanks for the reminder. Last weeks were
a bit hectic...

Anyway, I have just comitted the patch into printk/linux.git,
branch for-6.13.

Note:

I have updated the sample messages in the commit message as suggested
earlier.

Also I double checked the patch and simplified the comment
in the following hunk. The original one was a bit cryptic.

@@ -1185,20 +1196,25 @@ void __init setup_log_buf(int early)
 	if (!early && !new_log_buf_len)
 		log_buf_add_cpu();
 
-	if (!new_log_buf_len)
+	if (!new_log_buf_len) {
+		/* Show the memory stats only once. */
+		if (!early)
+			goto out;
+
 		return;
+	}

, see also
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.13&id=a961ec4e2860af4933e8c1763fe4f038c2d6ac80

Best Regards,
Petr

