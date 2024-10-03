Return-Path: <linux-kernel+bounces-348672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B798EA43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398691F2377B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8B126BFC;
	Thu,  3 Oct 2024 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tC3YU6A5"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7357D417
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939977; cv=none; b=luWmzFrz7gPbsxl5+MoDcP4A0A79B2MmwQxOa1uAVfpdQAnX8+giIWKp5Lw4ZsqDYSa8yf/ZBTJEfnFCwBZhKQK8TVcCuVbnGye0SWOsLtPu0VSyladFloyPjYWpW4RZNt/c9BaxQ5PrGckM3tzQheBJ/p/eUNpVZi0MygsSEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939977; c=relaxed/simple;
	bh=7bgTiG7YeKbjyvm3weg8CgfyvQ0BL6EN1OXX365N2nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf1hhlAOo/kh8tmoXCJGIGiN+sU0cylnpexMxEqUy20k1Q5FwDksF54mdnCLsiWGDGxJjZ+k5D5411+9BLthpkRvY7GBX8TsiJsBYsY+9VJp57F2AALb0VMtv/P3PV1trDnwXQL+lRRwPmZ+TSDe8VlHeyonrLkkqlAoREiMC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tC3YU6A5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so5908395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727939972; x=1728544772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pc92mG/eD1qJhIHap4UGeOuFlUhYYhxaqjIeGx4a50=;
        b=tC3YU6A5jAw0Ewvc9+DO35/d0gqK/nqdBRPkQ8iDEpcA9aMKT5GRt6PBv//Fvn9a0F
         cDzYL2YBbGcSIe8X0E+RehejgTNq1ojIz/2aSbeb23f0AOvMfz2OjCzprKZzAEPkUNK4
         pi1nlAvY/aTah5FRdtNyyHhmKe85LmJm6KUIIR4Eafk0GS1ss4driDdOjmJmSgF5mMBd
         /EBpb5Y8A2a1mTr2gLUY8eT+ITK7G5193wIOu/0QlV7jxLRLQ9GS5WTx8m87dGlYOOU3
         zqqbKmvWBzZxhxXABxv8gUDkv07dn/tk91VawAbZ7tvie+ACTJNbM1cb09DiWhnjhkO1
         ohFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939972; x=1728544772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Pc92mG/eD1qJhIHap4UGeOuFlUhYYhxaqjIeGx4a50=;
        b=YWOKtJUVRpzulWAxF+ZABhZ1JNqEgcdWHD/IWfB3Ity9W6qTPZTkXoKcHGq+TYW1t8
         aVY0574gK5ffo+gIDn09l9eTmb/WK1hYnPXaFC0fsM439JSNxQSrKneeHJqxPODRCwB1
         TS1Ju4LKdT/cGbbjWqvADNUIcOntGtdElqiOVLzmHv/cfOSw5m1e0UmO6lOd6lGu5GXP
         XLp+SAYlb48TkaxfzOWqn2woFytmRgc+hKu0aIhJCXU9vJnl6vNRxwXdhxBwzLeHnP+s
         lNYg77uPhbCeprlBbO3iK4BAxAn4Fni5Kp+RKCjSQ1mT9NLVXIYfUXOUtrAB2SDqeNv/
         cBAg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4KZqPwGFwk5ELdwZnJ4rCboDXITq3sVcwHf6c41jiFv7RkIYuZP2snqEPy8z9uNndwyGwBJjSnPNbjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7nMEbwEmdahHP4OEF7qYfoCp4qXeREuMGkfggK4Eq2Pg8d1k
	tws3wjbSkQQNsLNXIsTsiax2YlS1vf0V+5+ltrBlSXE1PdlUJriQ6wgbNqG6a3M=
X-Google-Smtp-Source: AGHT+IF3Xq0ydl4xX68VdKsqgflTf4PtHmWzxVp9csAq0PeQmy9j3pKy1BhFrZRNHaPzHHwfg/Pmsg==
X-Received: by 2002:adf:ffc2:0:b0:37c:cc96:d1cd with SMTP id ffacd0b85a97d-37cfb9d3364mr3530233f8f.34.1727939972450;
        Thu, 03 Oct 2024 00:19:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8025b414sm8087565e9.15.2024.10.03.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:19:31 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:19:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xingquan Liu <b1n@b1n.io>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: remove parentheses after &
Message-ID: <99ca03a8-8ac7-428b-b112-ea1efb53adda@stanley.mountain>
References: <20241003070353.65998-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003070353.65998-1-b1n@b1n.io>

On Thu, Oct 03, 2024 at 03:03:53PM +0800, Xingquan Liu wrote:
> Remove parentheses after & to fix checkpatch warning
> Unnecessary parentheses.
> 
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


