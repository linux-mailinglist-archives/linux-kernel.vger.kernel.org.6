Return-Path: <linux-kernel+bounces-220668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6990E53A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316EB284F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652578C84;
	Wed, 19 Jun 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lU0wTnSP"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD378C65
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784535; cv=none; b=Ry/GL4Twl4StUiklKxGNO9xN5RA6Xd8zcIKfkKcmQXWOyCNJfPYbQM1yzFtA2pHLylZW7pS+7TRKULkU/Uoj0hpXk8LEC4MoekomCc6JxOVVWb0eNgJ0TyU4WDvfyd0SBXwPCLNvSzmLyzPZKqTKfe0BBOTVYHi+pCEddHUxNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784535; c=relaxed/simple;
	bh=vl9KclTpnM+SdGp+CrCX4wdBrh0WCaT2cjnS1mhbu6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY2WBPEysR8U6nDPN5APytyqFP15ILwkGOy5ccjlWm46HLJIgjIdWMbvFeY30K2gSHjChHcMIU7ruQjW+Rt1fQlfEcQnn+oSd0tsHU5O+xkxPrInisM5R+radfEspMxyFkH6yTrVDPMj4OY+dbEXYqTjjzwZLw3STY7YWOkrBS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lU0wTnSP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso6528533e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718784532; x=1719389332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aCIcbRqN1/jGnE/uXHAlTtP9P6llAMOVezx7CUwbZqQ=;
        b=lU0wTnSPMAvIuSKq90Jl8+OhEO8j++q5qM/w6FDMiudR/GjbHvlIhTAn1RIIEFkfFv
         NuIxvQ+H6j6aowar2gU6DQYkPdkiilBDtt8jmnP3Zj977IReuhaEskXqAp8sx71CpRgH
         EhZJQKvEHHjK/V87UnbS9dxo/4/gmIXPFYSx68DacpM0oTHuooniaqhmOg1slPfcUooG
         Aq5fAbYuwjoLbfpTxf30Kzvq5RNh8Ol3HSQwvFPSQBPYkLkCkFpc6JFQpx3R1Ta5j+xv
         YxhJFG3sWoIVn14V8NOL1rXW7EwebWAmBzHWcnndfOg5YFbmdFfkh7yCF9dNEf4HFnPT
         XfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718784532; x=1719389332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCIcbRqN1/jGnE/uXHAlTtP9P6llAMOVezx7CUwbZqQ=;
        b=ukEhbAnP76+TevZD2Z/Z7qJkhiVX+kYg4SteQxDAoLaG3pkvxSySXqeeai/ESuxhtf
         wJccFQCbVWqcH20DvFTCWceHJ1q1JIU6Iu53+x8JWK/b3imdYrmC7SVWV/QApBpPRyBY
         zvGeLkTB7Ar3wFzo1SpMgTLkoDIlKRLQmE2abq6OdWhLp0Qvjlp8u7TgS54SkbVp0F0g
         YSxHlgstIDFM3lUWxpW9d/gfmtkBzcYiy/UZVGJq23WLxi3Jv0QqZIpd4YGkrI18k68u
         +0AsqJJeRb1bb6SVg3Dnk+YL+GpxxnvFyBozp7bsc06GjnM8gUyHeDESDi3qMX+sOGFa
         3XyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ05/GiFMuMZgMfwYQjXf9O97NXsMpyriAvcy9dQg1CGwYhUH7RcLlskWGx39zSDEYoylxoFjNUWCMBkNFPaiWLJIZboAlu7qmWR9b
X-Gm-Message-State: AOJu0YwzAlExiGZx5CQYUD/c+VndIyBcKvkLOR8fxi+vE02U8uqA8nx1
	KEJlPbMMsgxA3sjjHV+17E8me9SwLfxG5XZQCpeq1zFaMdjoYAf4QZShb/zxXF4=
X-Google-Smtp-Source: AGHT+IHzpaORTCZz1/7jsEDBtxbwIYMBPRLfAyWcTVqZGOfG4wD12iOFalcqhwT3dzksgJh+y2ozKQ==
X-Received: by 2002:ac2:4578:0:b0:52b:85ba:a278 with SMTP id 2adb3069b0e04-52ccaa62111mr841920e87.31.1718784531869;
        Wed, 19 Jun 2024 01:08:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36229be908fsm3478277f8f.38.2024.06.19.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:08:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:08:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
Message-ID: <aef741d4-d6e0-41f1-8102-c63a0fc5d7e2@moroto.mountain>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>

On Tue, Jun 18, 2024 at 12:42:11PM -0400, Konstantin Ryabitsev wrote:
> Based on multiple conversations, most recently on the ksummit mailing
> list [1], add some best practices for using the Link trailer, such as:
> 
> - how to use markdown-like bracketed numbers in the commit message to
> indicate the corresponding link
> - when to use lore.kernel.org vs patch.msgid.link domains

You should add something to checkpatch to complain about patch.msgid.link
URLs.  Those URLs should only be added by the committers, not the patch
authors.

regards,
dan carpenter


