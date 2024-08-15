Return-Path: <linux-kernel+bounces-288259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A7953804
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46896283581
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651581B3749;
	Thu, 15 Aug 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I3YFT+mM"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF11B29A5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738304; cv=none; b=HTO/bF+8uoefL4LW2AF4joVQrH/iVoQCq/mh62RQdipFc3FaC3/29Jwpkg0K7T7qNFRcWp88WJayC4w8afhWRDErXZCEL+FxnhT243xoSqpGct52MZgxKFNL8Peu8jYRkZKlPReYx0fKNTSe9AxVg5AHPndVS9lifKt/tfw2wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738304; c=relaxed/simple;
	bh=stmfQPjThOY5JY5xeIkuajVC8TaX1REhTG6g4I0TuS4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=sS+qQ1d+ptRVufKOu5FLxbMaUUXu4FOYNKDn6U+vPS9eICjwcOxaTEjxJinWd3H2iuMxJxWU9cbIAu0UuWceWslpn8MILQpJBxdu8ZaZiJldHnPpe96///qT9EiiJ8r8zRYZq8npb4sf+6O30RfpEj3mle9gSQK3M8q+OwpPzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I3YFT+mM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bb84ac8facso5297716d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723738302; x=1724343102; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJMlTsl69w1myQg1uCFGfwb6Hmq9ET+WkI++9CZ+3Gk=;
        b=I3YFT+mM/WAviM/75hFTw3+CbMcp/jt5bOuBP0X0ETsyTU48gossRdfpvQ0w1DH5zC
         HGxKw3Pyycm1z82bnrs7q+TGy9PaB9Aa1lLJWFiQO3mzjO39DnXwFRqU90CDh+EhOKvw
         9yNT+E1xloCTEDNv41KqisvyoQkk/nbxl42Xgiz7sP2uLPh4wDq0y1d2bWhRUqqqoHl5
         NgiJHsY+aaeybwetIAIPqaV1Hv920J9MPb1G19BlZqa2On6pLQX+WzVx/L1hMc7WSfWE
         ha2O7g42KZWUaed6gOV0cYGBC6je5eCmAaDHT4kppFmoWG0vKxgEPv+bQTaJxK1Rkun0
         ga4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738302; x=1724343102;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJMlTsl69w1myQg1uCFGfwb6Hmq9ET+WkI++9CZ+3Gk=;
        b=JddxV05whvmsRCDgPyjcUeh6XWOcuX1+eJnjxarPB//q2xisgJhatL2s2nNn/gAIWC
         JsixzSi/mvQ7cbZ8OSIz9Cd44YfsVwdpxE/XSLspJK32M6UaA5XpZtQ+aJoIAPTGyVFk
         n25i5SdC2JIWlm5EwUIYG7Ybhb6RsDI8gWWnYNhsVQrzJrd9lNvhEceICrEv1UaTtKL4
         YzP0rwp0mAczrqxWa1EWucxlr1hS8uuf8PYmzSjxD03cjnnEGFLp2IGBysKSLZNOdSz0
         QDB6qEEZ/+fgPMGw9nVDPCi5TqfSeX1tr0PNgmT9b1qu5ASLfxAAgAPtQE9P3gqrcpVv
         LEuA==
X-Forwarded-Encrypted: i=1; AJvYcCXLuHSCY7M7pifYjgqDoFhN5eJFwl30A/Uo/ND9l3M5kPgxHlKo1MZfQ9HtqwYU4oAQJbM9xIITpwfLbBQiFX/v1QxoKb8UtNrSIfq/
X-Gm-Message-State: AOJu0YxrQe0RDKTAg0JjicOBcl374HPeKNj+UGaWx1nPz8AKfwSLGFpN
	ZBIZEgiecYkgd9ef48ucX7MRZ1akYqlz1AED+aLSkim51HOf+HpJyaENV65NjgTvTbmrrtlFtiI
	=
X-Google-Smtp-Source: AGHT+IHQ1oOJcKiCksF01aDFCB2y7+5wp5A5LBl+qgAXT7t5DQc/XTTEcSo/ahqIW74tm7SnPGG2NA==
X-Received: by 2002:a05:6214:5989:b0:6bd:7f27:3565 with SMTP id 6a1803df08f44-6bf5d1c5053mr81869636d6.6.1723738301725;
        Thu, 15 Aug 2024 09:11:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9c7esm7568686d6.4.2024.08.15.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:11:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:11:40 -0400
Message-ID: <bfc25c139caf8eacc02973b94ac05030@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Yue Haibing <yuehaibing@huawei.com>, <jmorris@namei.org>, <serge@hallyn.com>, <kees@kernel.org>, <casey@schaufler-ca.com>
Cc: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH] lockdown: Make lockdown_lsmid static
References: <20240814033004.2216000-1-yuehaibing@huawei.com>
In-Reply-To: <20240814033004.2216000-1-yuehaibing@huawei.com>

On Aug 13, 2024 Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> Fix sparse warning:
> 
> security/lockdown/lockdown.c:79:21: warning:
>  symbol 'lockdown_lsmid' was not declared. Should it be static?
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev, thanks!

--
paul-moore.com

