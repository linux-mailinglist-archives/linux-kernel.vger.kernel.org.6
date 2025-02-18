Return-Path: <linux-kernel+bounces-518758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCEA39412
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCBF7A4608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70671EB1A9;
	Tue, 18 Feb 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVET7U4S"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44B1EB18E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864891; cv=none; b=HWnzquysLrkxgd7RRaeb01A//OQGIWcFRab111wqs1NdIV6sd88Il0JrndOvAHzKSg8Ynv5Enpw0+rmjmaP9WwMrYqboZxqwzL737M7ZTkGFjCYC2oJlRmT9zTRZRNWcpBsGJ5CIkHvTc7w29FiHLTHe+J547fzxsLHy/iRk8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864891; c=relaxed/simple;
	bh=NyklA13Dg9i+m8NkOQ63eTCA+Cty6PL2AVsa6doGskw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhjufJ+YhHnB4AFv54NCPjD4O6VeSTpFA08KOPHp24gGCbXXG3wm39EJwyE9/Do2+avwLGhZ6zGf0cUzVgQjl5ROmJ0rsJcbpdmRnXklWEcccCk8sdPvHlTe/8UI7D2hYGNejXGUx+GEvf6vUyOKX4f1FvAW+xYnFOvtKdzznpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVET7U4S; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb90c20baeso287051766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739864888; x=1740469688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnwvAMuVQSCRRozrvNJADX8ge3CuPmWawHTGZ6gaoIQ=;
        b=QVET7U4S2pqcB90o5h3sM1yCNd9s62NFq+2aX9wZ7XhL+lkKcNSsVe5KW+uHIfv4Ok
         j60tjUa/PIguo+bFfH+enqGrlmZ+LZO8h9hPLZu8CcDDwK6ZK530smcSuI+K5nufgJwk
         Np0ox1mYu7tev/V41vvuzZTOTsOPtLa+IqQvXzhAaoQ/qiWS2V3czD3DqOVFnZWn7kPE
         Pt4Sv4nGuexqI9TF27hyQGVLHqkT0KHy7kXw28qCRhtC63HqIG1rwadxXpoRV/Pf4IWm
         BvGNr4EuwNtmenkliAlJzOtz49IY1YckHjgab3mCE2Uevji6zL31eIfeg7SNyRnkC4EW
         nshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864888; x=1740469688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnwvAMuVQSCRRozrvNJADX8ge3CuPmWawHTGZ6gaoIQ=;
        b=SDoMZkQ1cnpOLy9uWv3OAt3MQoHTxUxU35wnYaMcqs3UIS53pQamd/Ou2qcnVr6V8x
         1vGhIc5SpmDIyp8m2mieBThsWr/7vpe2rOajkGbDsBgtTs/C0PoTJYn88wDb9eo7mI4z
         tjDGPJDKTB6/7mukNhVoJFGHiYrHpWPtHtGcxk7b1V3bhcydFK6JpCDCT1+q9mf/cjMo
         RkqDUZ6Yuty4hfToafncivN2up6mNXc5oP/r8/P4LUd3L/q1WXt2fd5kTQ+MUsxu4joN
         0ujow/PEWl91PGyWPB5pN0w4ShhsJLAFyvndyZAPJSm+1Fu+XMttKREV/VSjnCXMqiZx
         1X9A==
X-Forwarded-Encrypted: i=1; AJvYcCW44XBV7hHTMaSnwNW0jBJw5sdChV2kvchqJFjOAF41XOOEbpctHEiKUlADEUl2+lCmgJ7inI+F+4IomkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHebdFmIw9xQziM5PJR9cKgLqxB+xGIdyfXEX2eqKhguaTEK/z
	4iKMKEsA4U9G9V1xekOoqdz6xixxUNVOMkAU05eN/5ataMN87dCJiNOlP5Olmfs=
X-Gm-Gg: ASbGncsxYyXqLjGDDjisz3cf3lslCcUt2ge4yG6/kdrsqgKu4g2GILG7Xxgr36BuREs
	OLl00cBoOtDFqDtIsyXjno/+tVPNcSgX53Ddq+1X8VhTVXOX+ebgUQeyHedBqhWtKCplz+3NJT4
	JL0Bhe7BqHWhJEEkUwvNjdUsfilGOgI+UD550evQ2D15zd2M3NdIo9wDDtgfUigMVr1hJ5/oyuC
	cxRkqSdgJGUvi7CjzOgEap6nLt+FBJdABVbZ4/biOkhjHDgzMg6VhvnVmBzY0JgbKPfDc6NJqFl
	vp41Ola0GGbONvwyqTYA
X-Google-Smtp-Source: AGHT+IHk7Yiy7MzG1HeqNaUTij3OexQs/BZTmTN/h+Lrj2OEPwUOnLWZ6xFUVh3ErJl8crizrrH1SQ==
X-Received: by 2002:a17:906:3118:b0:ab3:84ac:4dbc with SMTP id a640c23a62f3a-abb7052fcc8mr1092489066b.0.1739864887694;
        Mon, 17 Feb 2025 23:48:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb9d1a0049sm303370766b.40.2025.02.17.23.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 23:48:07 -0800 (PST)
Date: Tue, 18 Feb 2025 10:48:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, kuba@kernel.org,
	rmk+kernel@armlinux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] staging:gpib: typo fix and cleam up
Message-ID: <4b1bf65d-bd16-495f-abb5-3d59b65a59a5@stanley.mountain>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217195050.117167-1-kumarkairiravi@gmail.com>

On Tue, Feb 18, 2025 at 01:20:47AM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> minor typo fix and cleanup
> 
> Ravi Kumar Kairi (3):
>   staging:gpib:agilent_82350b.c: fixed a typo
>   staging:gpib:agilent_82350b.c: cleaned commented out code
>   staging:gpib:agilent_82350b.c: removed braces from a single if
>     statement

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


