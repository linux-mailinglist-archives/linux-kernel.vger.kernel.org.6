Return-Path: <linux-kernel+bounces-395691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E909BC1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520B0B21841
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3B1FE0F4;
	Mon,  4 Nov 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RB0N9pDj"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF711C8FB5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764518; cv=none; b=t4ePZ+jtvIqP/QL9vHDihJfuf0JrjHZIPf7EVvdBXMQTRIg1jJVRwuQtx2CSHiaOrJN3BE4+ppVW0VTwLaF3+EManjKgRMFcC71URLGtSRDThd7BaJhjfmQEgVN1cAYGOzkBFOJ9U1lWwLMWwPFaYaf+/eM5aCRXhcTGIf8xs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764518; c=relaxed/simple;
	bh=SQPYkT47hOs+WYldnCS00UuH1aSAzNu3lkFQnfZn8zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB2Je7hBvR8lOW3L/YSO2xu+9fcCDygeBUGKkWU/t2jQCja7t7pPShoywB069kjISHzS8aFwbzhkaS+7VpadnnPQ4UojKG95eokgnTHrmO4ksLgOH88+n+xUFmh/ekG8u7aEjleEKs186imZRnWOzruyMa5+RymOjKnqc1MvP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RB0N9pDj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbca51687so45634685ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764516; x=1731369316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdnfp77LKN/DlaR7y6ZRTeOdlisM2V4uYL3wKi+GwVo=;
        b=RB0N9pDjm/yaCKnvJXBe95kJNzLesKiaUOANfhkRCyqegEQxM3Yu4lBaB+we7Jcwx9
         LOhsWfiVmpaUPtsQVcefQAk17czxSzsPHe0bsqAqTlLlDWBouMNX/52k1r4kikQE8Rxj
         mo6gJhyffEOfO/zlB9b6A7GzMvc5RvkkkN/U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764516; x=1731369316;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnfp77LKN/DlaR7y6ZRTeOdlisM2V4uYL3wKi+GwVo=;
        b=LCp+3cAP5xAk18QU/hnVmFRGYUetM+42sKBYF1SYxn2T3+HgAuqHX7D9McD3Yp13xZ
         KPplshW5RL/bIKb/0nkixUrpQV+JL08lIuvZnMoAfIy+VhXi2apYVSdbD21GIj2mEgRj
         mofAO0QDOkUQIQmaDYb4vrGyJ8F1J2+/sbAWozDAvEYa8HRLt6GNveEYnjiYy7Uuv9GR
         PHHPs9tBv1gR3U9WaOmV4WVd5A1Lq9VGk07Xlo/7mE201rhJtzOdk8R/F1ckC2T6739r
         aEK+Nut5l5i9nj9nLzHZIlp89+guRGpfmcRhMhne8VCqQJ487JN9h0A1hcaUJ8hJC0SU
         c7lw==
X-Forwarded-Encrypted: i=1; AJvYcCXgP9zBUrVv8CB8rmmJphtpq+k23CUHuohxCaorc9J2fCAxUmm5PIkteYsfGmVnHfgPq+k/FOU2KuXbuy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycByLdkrG4CobZhCeiq7wiW7rXL/qOtJACLz+lk8iiqTsHnoPz
	ax5rde6SERIuXxMi2E+PVPq0+mVROeoW1NQZKuneNCL39WBf3O7sf6u9da/NIho=
X-Google-Smtp-Source: AGHT+IFFicJJsCVy+lROsW0Upk7xis+4h5Hml5B/geSkDDTcfqZIgZUyHs5LYZCG12/IYRuFTY4ZUA==
X-Received: by 2002:a17:902:e552:b0:20c:5c37:e2c6 with SMTP id d9443c01a7336-2111aec87d9mr179112995ad.11.1730764516098;
        Mon, 04 Nov 2024 15:55:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edbf6sm66708225ad.43.2024.11.04.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:55:15 -0800 (PST)
Date: Mon, 4 Nov 2024 15:55:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to AF_INET6
Message-ID: <Zyle4LszJdMOudRP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-7-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:24AM -0800, Stanislav Fomichev wrote:
> Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
> can be used to do v4.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 99 ++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 28 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

