Return-Path: <linux-kernel+bounces-437508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC69E943A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5CF18805B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943E22A1CE;
	Mon,  9 Dec 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hD8xq5UD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071522A1C9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747570; cv=none; b=Z3ucuw009FMNbB7hSj6l1QhQ6IuljVmciJ/sVNrBTrtrVNp2jNvY/5FPlUsr+f5yczzku+rsw5vyCA48gkzf+3220/SpJd/htj1558920WbjA5myN4l9vGPuh1O0z3zpNX/mLPYki3Tpqu7pkhsZOjxXL/5VG4aBpy6qaMEgcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747570; c=relaxed/simple;
	bh=ojkIf+NJwH2pcMn4s5pw7xVqm1AtSmgfJH/UKFJ2AUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF62vVNc74UiSzjt8mKOgwJHx49uYVl+UYVBKUabdTmFAATXzy1rwfoL7ilqbfj/0wi+hB8ucWXTIqwYevVslJq+PQ/Xlr0OItsacC2jdTd/7eZoq/j5vdEaYyBW0x+dzLHjp46yOHS/2gqlZqyHquptUf1FJuU5PeSiGmlPZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hD8xq5UD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso47875955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733747565; x=1734352365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Njj/2vIxm5FJWzit5BXmu7RICqBEVd7qNdhzquAV+XY=;
        b=hD8xq5UDhCn6nSE0sOsojROYW8s9rftZr4s47l2KZbLXJBSe5x9sNl6h/esYwWp2EI
         9+xbNXZGqYpB7fcb23YTxA9qRQx9gX6NP7nK6Mc9TgatCCNXtunH1PcOs2jlzS+OwqPF
         8Q8KQs0/aqwBSDUbeIEpjL26wpfCRuCsGkrwvAsjHyCJDAJlk4u+jXRKyvlPlADtsaN1
         IHJCkSBYM1uxyb9dkiCPrTBLQPZV1H64Y5y+ePQpt5SmVRXNzaHsNTLVtEafKzt0DDvT
         7Ljnht58tzuinlr5dW2EG6aw6Z2MlYzgzeKij7DynpKOFSp2qpMcvCeb5+qONY1DmRd4
         4ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747565; x=1734352365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njj/2vIxm5FJWzit5BXmu7RICqBEVd7qNdhzquAV+XY=;
        b=fedGnAp2CSz8CVV3odql+5XnjEF24dQ5epcs+cPpVYa3WVpnXhRhJRsYpWVwEmF+uc
         TMuCUIgq1JxMKlOfXwYMRzR9xmBN9jGfwJ4Bx4axneiVpolPR5WhJRKjjbaLy5KdsweU
         yEmpxmHmFdXjW6tlVgtv3cwuk0wbYAbhZ34VyGLjr69kCA4SInjB3va2wlbtOrbNabN7
         JeeP5dlLXL0WvhdsbLKnYy4Ub3gHCoXeXK4Jg74Yj36T5reThJk9Ga/4B0nTfTb6+WFW
         b52ksayzKsEwbUuN0wy9ViRy/20zC5B2+B8dgv4cdQdi9T5LzCSCOXx2/elDOKywszAe
         q5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcoSYNkHQE+jBXjNCo6tjKSGg2+rClsLijMubzoFpJf+AAR1kfvfR4e9tZLN0KM1BR1IU0PzpIPI2rv3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTaBUXvYMRBBQMDhRtjFZ0wx3w+Pj0c7rkKNEUPztgWRYnjqK
	7EzXK5/8Okn0rqi7lnWQ81q1url/OdUbBKyZ1QV6bdTPHxu/v1NUyrUciV9ITKE=
X-Gm-Gg: ASbGncv7cPDe/7KkdqSdoO8J9FbMaNHQkKthRPOY5CcxDuMvgdpxTuQkc6A3XHjurmQ
	w27BGy/ukNQNESTlZ0JS2JAlJFxrdh+d52m0hwoj/K2vut2VzogNBl8V/wx8xkPkiXzBeF4QmjR
	wJq6wbyKOZ37tAsCEB7AlCNeWZh9BbIkpV32yu9k9dIzhBiw6M1z4z1oGezII3u8doslGeYIAR2
	vBtJR4rzeewh8cHKRaAdmbGT+g+t9QsRpUpjUfDE6KS329gTl4=
X-Google-Smtp-Source: AGHT+IHnmQQkF/LPk9+MyUY9bTIlrMV1gwhUOk65jH2TYml3ABaVJ5nzEP6I6U7EmySutmHU06Ubmw==
X-Received: by 2002:a5d:588f:0:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-3862b3e63efmr7362064f8f.52.1733747565141;
        Mon, 09 Dec 2024 04:32:45 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21628b6f47esm41089055ad.35.2024.12.09.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:32:44 -0800 (PST)
Date: Mon, 9 Dec 2024 13:32:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Wardenjohn <zhangwarden@gmail.com>
Cc: jpoimboe@kernel.org, mbenes@suse.cz, jikos@kernel.org,
	joe.lawrence@redhat.com, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] selftests: livepatch: add test cases of stack_order
 sysfs interface
Message-ID: <Z1bjZbgj3JjuJZS-@pathway.suse.cz>
References: <20241024083530.58775-1-zhangwarden@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024083530.58775-1-zhangwarden@gmail.com>

On Thu 2024-10-24 16:35:30, Wardenjohn wrote:
> Add selftest test cases to sysfs attribute 'stack_order'.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Wardenjohn <zhangwarden@gmail.com>

JFYI, I have pushed this patch into livepatching.git,
branch for-6.14/stack-order.

Note that I have substituted /sys/kernel/livepatch with
$SYSFS_KLP_DIR. The SYSFS_KLP_DIR variable has been
introduced in 6.13.

Best Regards,
Petr

