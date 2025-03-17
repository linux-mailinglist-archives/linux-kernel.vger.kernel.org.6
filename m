Return-Path: <linux-kernel+bounces-563620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C3A6456B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA5A168C70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747421E0AD;
	Mon, 17 Mar 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhTiC6F3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DE946F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200179; cv=none; b=HwlabbR0D0MiJhxX8i5xwUx9TXET/78O75LmelNEFeCeCY7upEcigTOa6R1dCE+sB+SSGpmF0UZqIGvw74PgdNvPhe+WWGRkQYfrjnpx2OtIxo2+vYYoVZwAySEWiXE9V5qYDNozqaRrCeRwhnszO38Ohru3I2BaKRQ/HLddWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200179; c=relaxed/simple;
	bh=n1xIQSrRJa5OuhNxyRBXiIV6g2jzVCOVPVoRSAekBVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEYTXNPNLlNgB3eMb1BF1Ou4+n2ufeAO+ZxgCISqzKHtrrkS2fzRgMKf4h+tqakf5pXKL7ETJl/V+oZN3RRGHMMsDGruYATt+1xfFxOmTCjwObWXxsZM1EaQt4UOdTFm9c6fUYEeiGuSH6r3CJaXP1js2+8HQPB82E6q//wdyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhTiC6F3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso67695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742200176; x=1742804976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tpCHh1sGUtcnNsDeihPspb0KQnUPr7jIipRAzAMp7k=;
        b=OhTiC6F3Y+qDQ+X5YHzxZbtMNliRzzctl7IIJnGETaAZHlsyUjhx+PbjIj5MqMoD2A
         F6KZjogSJn4+AOkVabaP3cjIOuhDHIIZe1TuRd+gJInJpWZrKxqFQYm9aLW9OGMtuopr
         jKMpP5Cg35NwGlxrOCGu0lmDr34NYuyBi7xdBf/t0Ae1RNxfxXlDMohh0mu5JL+10pIU
         8ZoJFTfslYmhXvH70DVeSVLkSHWt5M29hONoSLxYkuwYP+N+Ps8rncQubutkvqwOGGrl
         C76dni3ivBvcdEew2zs7B9+higeJ3Fwoj9SAYyo/YUXv4ES6VZgbWNPMpC/f8d3bUpYq
         N8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200176; x=1742804976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tpCHh1sGUtcnNsDeihPspb0KQnUPr7jIipRAzAMp7k=;
        b=Hx69almi69N/KGnF2/AzKZu9+t3DYoWKw5P3X4zH94WQr63TJhnwr5l9Aqt4Elfhev
         khlsReWEXXV8RFc5beWwqRdj4Yv7/2Ev0hIMWtbtJtGMyuGhl9FoUY4sE8oNWoRjwaSt
         1PaRIRNACUU6jh+BNJWb0EKCiCt5K9UxY+RomgkDjRyXb7hIWpAwwFdbYWltNYsTnas+
         qFnPB45vM4iQMK0IFVWobGtTPejFOwUmE08BPsUGKeE2TSm/r9Vd+FrQFlJBmGyqPhs5
         uyz4U6C14o9KQEAH5UO3Y7kkPFpi3Lq+fZ4Y88z1MNSlmBCLIOKjFJRHlNxnf30MR1Xn
         /0hg==
X-Forwarded-Encrypted: i=1; AJvYcCXxQvBTydgGRmws4FNPQXjf/Hq+5Oha8qI3ncxxG+5tWOYNKKCQgwrT7NmMg7sIM8tlA1nPbK0eW99cCPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VxGOTPVZaDhdnfbSjhxexNmF97jRqOcH7Ah7qtnF7FD6+0iQ
	3MoOnjYuuAx++bNRv2iDkydF0Ywyzaw57SzOsVqQvk/GawnxvyyCgocbLwAiiA==
X-Gm-Gg: ASbGncuwmBtt5S6+Ad7vbXrvcJHGRyBmIGW+3LR9prFurOR45pVkXealbw1EZ+KjEL5
	jwmcYW9UT8TPMLuVUG16E/+09wfQd/iojALUW/AuIh81BPOmU4o6zLIk+9PE2yg4qZD5UnWQY9K
	gp4Aavg6Z/du6aOv7ZUlsLxXmh2eHUz3qw2nt6rEyplf35mLbWUUNHZZGM20g/FndLCtZLXPZgQ
	apJkOWVLAQliHx3DrSdrTVEUvufrwNpiae+dxyg/lAnCcsKBx+bEPnrPQlHtUOeX7+YrNFAnR5l
	88XPUSqWeJc8cA2ofnNcPqOKjadOsSnmcmEcJeJTLI6+d3AukD1XUZnDU16QkXqBmHzf/mZyJjx
	nDlpxq7Q=
X-Google-Smtp-Source: AGHT+IHiL+276Tj7jodp8cqxaAj9TSVNQ+QP7lOl+zUy70PNCZbRRXj40hTzzHUVM8870Mupc5Do9g==
X-Received: by 2002:a05:600c:6d07:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43d2518e332mr2323405e9.0.1742200175992;
        Mon, 17 Mar 2025 01:29:35 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb626esm97780495e9.8.2025.03.17.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:29:35 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:29:30 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 02/13] objtool: Fix error handling inconsistencies in
 check()
Message-ID: <Z9fdasqsARmQf6ZM@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:00PM -0700, Josh Poimboeuf wrote:
> Make sure all fatal errors are funneled through the 'out' label with a
> negative ret.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Brendan Jackman <jackmanb@google.com>

