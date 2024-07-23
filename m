Return-Path: <linux-kernel+bounces-259589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B736D9398FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB71F2221A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623713C677;
	Tue, 23 Jul 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZTflS2m"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154113C8EC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721710287; cv=none; b=WzoZ9U7M8d5JZGxoTd3ZmWgl+l7/KMilcubgVwwi365rmFjJuniGmWFylecWND/3j4FSxPEHoxyO8sgc6xp+rOcVKQOiGFHHUup0DDkuAJIG2JJ6A1O96cP9ZVkqikQFaWt4Gdk84yxjC464LXEm4Drt/Na6zVwrGSzlsEjqpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721710287; c=relaxed/simple;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL63MrYGZmsVwuchQIgaW5kEdluNzYxIDytQcxjuDRYBS0gp/uxKPqYnE+dua/QLIJ0vCRd/7+BD8N45CjEJ/CSDVhRjmSDAPDn1WYzK+dS+kpCd5d9soQg2Kj3coHJWH5HQFnQam3xgkgfgzBuXjKAlYTxZlIlpdhYTxUvGFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZTflS2m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368712acb8dso2381228f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721710284; x=1722315084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=UZTflS2mB9FkQbAvRV38twSK3cmMvQTYr/TrM/1vEYATWDhbjDQch8o3IrDVAzwHZc
         J30yutLb0J+8MInQ8C2/rI/dwiWMAuTYvg0qxu6IkcaIUIJdKe7uYUEoBVsYsVc5x2/t
         G9ruMr3zxPLn5Z/N6CYHNwGhoxeFigj5tFRtjAorwIhp+KIaNqBhLfN/t/8Rv1xfxsqU
         6hyvRIlP5CNrJlu89UDmIZsbOWf+p7uJmav5HmSMmQfCEbl6awJF8EicrpL9Es1Hwhgy
         6GNdLjYjwLJCtMQd94fq//jAhkxBERRooKkNtqUiACpgXzUh/nka1UbpTPaWeeYR+bwp
         1Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721710284; x=1722315084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=ueG+Ci58Dw4g4i/8JFtoTGociY3C98/8xRtrjngE8g23v1+EwDTc6EfGk0cRgv2lpE
         oZK/626WGQY0mh8BAaJwWa+pVOl3muByUmA8bKC466PyKg8pL1xiPvx+ib1577xHlw7S
         BPAwFzUFlQ9lXkE1IGgKMlD/WJaszuWlopN6SuVvbfnES0IQcfzN3GpsQo4fHD646rW7
         IeOhsHU1NsJ9muMDDCr6ZR2arGzohWZBK7RvJeUcq8SgsgDRBeYoxBF51hfUz546Iv1P
         MtN4/jyN6XjyrwKe7OdtyUjD7Uy9oNu95vvGGI1/EP5m+SsefXSMbPO3xquuiwMkAngO
         I5nA==
X-Forwarded-Encrypted: i=1; AJvYcCVeP4IjaDR6K19OY47nRFBzCLjddVkCYfj9zRnqO8+yaVpOpw/80AwtTn7xiZT0vJLKhM9lnaMas8ZWg298NFLZGWUMljlMuz9dBK7y
X-Gm-Message-State: AOJu0YyIXM+Xls9qxunhMf/ci7yOT7aLBxMt1sM3td1SKaB4TN/rmnOQ
	4dFAbd7xLCoeWKlepjRO3JK83WD9jHKO0eVzvoUxC6taTB0CZT6RPip//ClAeZbFAaSsKNwZBba
	hWv5NKZa+H1SqvDb6zHBMiOsNoMRxrxVBqlPQ
X-Google-Smtp-Source: AGHT+IG2djanOPTkwqVUsbPFqeMu/LXMrh5LaVa2ONuno1phEQZhKl74d/UNoiFTlwT/EaSCIcRczcStMaWrTCnhUEc=
X-Received: by 2002:a5d:4576:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-369dee56da3mr1046156f8f.55.1721710284258; Mon, 22 Jul 2024
 21:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 22 Jul 2024 21:51:13 -0700
Message-ID: <CAB=BE-Qqrtew6KKEjLfiEtcc0SDtP8PMhtby27OtF2eD-dD_iA@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

