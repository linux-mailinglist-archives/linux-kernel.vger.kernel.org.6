Return-Path: <linux-kernel+bounces-352620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D1992197
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE3B1F21017
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012F18BB95;
	Sun,  6 Oct 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t7/yjBiu"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1D189B86
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249309; cv=none; b=enqRcXXbcZYLrieivqlbfnO+XvQc1sqYdlwPDehjSodcYmUrKgl5wRvIzaRWcraz19TtvUKVem+lOFu0iBSq+D+/EhdubA4eyl1knz9V734M3/hW49Ovf6CQNEVwJvdluRAWPkGG5JgqcjGx1CjVP+uY3U0GJn9TBP2IX5Tr4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249309; c=relaxed/simple;
	bh=olXVaDRc9sKDu1AHJMByKbhJ+ny2cgvTV8X/DLIB2Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNWvk/7C/wdERkdg9KRdfFfMLmvOGd+by2glOfkjeXz5LzkJdewKucJQvDNwXg5Tr5VH8qRauR5yf1JTaWYIWfPlwVZDzhhKM0zTuELLL/WR+niTWYAvPK53RS7cQU8VCUh0UBDHjTntRHVRjDp87qdrnn+H1y2CHyReGkyF0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t7/yjBiu; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d380b464so3049541276.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728249307; x=1728854107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6BpBixglTcARBO7wAvcoT3IQ3RW81geceCKSOyrBJE=;
        b=t7/yjBiubx4fcTrKVMeie+wsrrtAH/O9XrEkmHDr+l2T2YWPUJ2t4CV6/yo65o40ps
         Tpi5ecUD5/nkrehfQvu5IymMa7E/xkamV4JV7GG4ScDopJyTBBq7FJuM8lr1oD5uyMBi
         ++mt23nZpjUc0y/SsGviyM01im3XiLiJ16Yfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728249307; x=1728854107;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6BpBixglTcARBO7wAvcoT3IQ3RW81geceCKSOyrBJE=;
        b=TEF0E1ykFKP0O7c+ijrEzt1iNjK9rp/N8FepsLsz5wjjIQ/tEeR5MUkhwfN4HTg2nM
         zpMAvRXw8yoHHEaPRzrVIuPZz8CiNDlnxesYo7vO0fZl1REvcLTGWmXX3vOeCGGvjNrP
         Sm8IuZuxYyPZezRkdzLTFDGcFQAYzI4q7dzIKPa8GGLMfJFXjQzVVIErud9bqwcyRGfF
         GBbI8eYzH6Eqt/+GaZ8GsFnfSOH715htHZPXOPdYyvugI5zWgIw50R1tNvp7EY8k1SLH
         gc4VzYmbjEBSRW8YfCsNTi+gyyUMeZMO8Yclk9KXcSbK+9V9RAvaxUIJOnJNNVU6zw7r
         QLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXp4gGp60M89s3ofn/u5uDBnWT4pBhl1l42MXjoPZWT2GIR145uOMkr2IIxv0eqStVescnzxdLRJ+V/X4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffUnThzeiIDwEDlWeZ8Z4YdZQ1BpV2IJB4V6CA8m16eOuXTyT
	i4mQyFGopbHxM3SV+bl3jyUaIIgjWD+HtKV5fYG5h9bsXg/CB0VhM1j/qrZ3c6Y=
X-Google-Smtp-Source: AGHT+IHSNEBMZ8pwaFq0A8lXnAil71lx6mGkLqiLShB/xAcWY2MPUF5Fh34gf3bdCBLWBtDfnXNHDw==
X-Received: by 2002:a05:6902:2382:b0:e25:ce5f:42cc with SMTP id 3f1490d57ef6-e28937eebfdmr7612253276.32.1728249307153;
        Sun, 06 Oct 2024 14:15:07 -0700 (PDT)
Received: from LQ3V64L9R2 ([50.222.228.166])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a593b3acsm692395276.2.2024.10.06.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:15:06 -0700 (PDT)
Date: Sun, 6 Oct 2024 17:15:04 -0400
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [RFC net-next v2 0/2] tg3: Link IRQs, NAPIs, and queues
Message-ID: <ZwL92CHG9YlNKto9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
References: <20241005145717.302575-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005145717.302575-1-jdamato@fastly.com>

On Sat, Oct 05, 2024 at 02:57:15PM +0000, Joe Damato wrote:
> Greetings:
> 
> This RFC v3 follows from a previous RFC [1] submission which I noticed
> had an issue in patch 2.

Apologies; looks like I botched the subject lines on this series
somehow.

This should be RFC v3.

