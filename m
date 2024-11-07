Return-Path: <linux-kernel+bounces-400464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538029C0DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F91C2240C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD921732A;
	Thu,  7 Nov 2024 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xBD5jLLs"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6862170D0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004893; cv=none; b=Jninjq5EJncuf+C9rwYznusgKRdzTwENXZ/8elCte5vZsXARnMWflI+eTW2PaTbbRdANiAev+Ozyoh1cvDkfFCqaCr62uSJbAsmmNRPgbZN5ZNc2N1pexTPqnUXAoy53GcZeqm7qlOEH0FyaRH7VleiOkgjH6HFpQeJvFJlqDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004893; c=relaxed/simple;
	bh=UERtUTdDHMqwEOd3lG+etdQyUOwMOZk9I0ZLa49Xxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGlI6LOswvLHjJjeT+ggUPVdu/pLlw/+qH7Y1w4SBhS5oBuA9rMrBIa9Hz1ViuaYCpGlTaP8G+cfITOjZmVpEcUWyBH62PE0dm9UNEp0WqAC1vOppjw2Af1s6ytEd7/Ys9kCW76IhMPO8KYhcZZmhpq4tAnMsSlkvkKwOs0I8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xBD5jLLs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so1027172b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731004891; x=1731609691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLvZijJPBYZBPFNrRc9CKq5D8gjQkE0eC4VsMFrsad0=;
        b=xBD5jLLsrenqp2ygQOf6la5WzwytdC81+dQo850RgHo/Rui/XAAY/u+CvzD6QewZ1s
         15eMMSjauleCGA98TZCC7snqoZDRWFjrMAol2E+fP02XzaR3F5YxsBmqsqpVT5kKDAEF
         rU+h1S13TT63i+kthmbj4CFp3noysZWPvwSlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004891; x=1731609691;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLvZijJPBYZBPFNrRc9CKq5D8gjQkE0eC4VsMFrsad0=;
        b=uwlBeO+r8lgfpnZmmvJhBhgJKRAeJ3yNBWsyhik8gNusXppK/895h7+/AAV/yltjXO
         eHRCxC6kG28EiOiIYSpf8as3Dm9EBZHu8s9bnti3OK1Y2CfIswQ6/g36HT7rSqAcLHPt
         v5noH204q8EVaW9UKL5rvHkuI2FWz/auMxz3bWh7YoldiZH/jfU8beg0lxiQdKqlNIAN
         j55Zhc8j/w9sJ6Jtx2/kwU420RgRQ7MCApLjBNPfek+1MvhbphmKqaW8K45+a9kcJ7VE
         7Mwz3X+/uuhXUdgHPWPChpIRs+XdwKDpVIYfaWPQW2Ze1WYV8KtbGA8DMX1ntrgp8qyD
         XXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpNF1g5aEHemboqN40MxKdNcQP/lv6l2rkiMR3scHvPwykHmhfZd0IN/iR7s7E7oiqr0oS811hjn5Q/0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMT3Rw9QMzwr+2bAtheoed+IsJQ8+Lmk2oGYV+vxP8Go76Fe3
	n8cSMRPAitp1wVBtsqPBEqEiunMDyNjYSOR5JuIzdorixyDkeeGoiSkz47i1w2w=
X-Google-Smtp-Source: AGHT+IFHzVL/PBrtDcFLSiyYckk+RtSh41/tBpAJWxrPImNnuc4c3QdM7DvQkg+YWLtnu7Psk/nk+A==
X-Received: by 2002:a05:6a00:124c:b0:71e:722b:ae1d with SMTP id d2e1a72fcca58-724133b687emr79747b3a.25.1731004890933;
        Thu, 07 Nov 2024 10:41:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa994sm1979872b3a.129.2024.11.07.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:41:30 -0800 (PST)
Date: Thu, 7 Nov 2024 10:41:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v8 00/12] selftests: ncdevmem: Add ncdevmem to
 ksft
Message-ID: <Zy0J1_3P76EACrBG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241107181211.3934153-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>

On Thu, Nov 07, 2024 at 10:11:59AM -0800, Stanislav Fomichev wrote:
> The goal of the series is to simplify and make it possible to use
> ncdevmem in an automated way from the ksft python wrapper.
> 
> ncdevmem is slowly mutated into a state where it uses stdout
> to print the payload and the python wrapper is added to
> make sure the arrived payload matches the expected one.
> 
> v8:
> - move error() calls into enable_reuseaddr() (Joe)
> - bail out when number of queues is 1 (Joe)

Thanks for all the work on the refactor; sorry for the nit-picking
on the queue counts. I just thought of it because in my test for
busy poll stuff, netdevsim uses 1 queue.

Having tests like this factored nicely really helps when people
(like me) go to try to write a test for the first time and have a
good example like this to follow :)

