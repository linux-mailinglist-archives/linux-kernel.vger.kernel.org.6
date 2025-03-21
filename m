Return-Path: <linux-kernel+bounces-571765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C5A6C1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636063ABDFD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48422E414;
	Fri, 21 Mar 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JSWPP1OW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98A22D79B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579634; cv=none; b=CngZHT6EQbwvTkqlhCzNMN8Y+atbq7K1qFSM0/YiMcYCsqIy9I7OKxCExpb8u4fTYOFJL8iMsuZlCKQNu5nc+QnWibdMP1FD61WCeU2MbjbhwhFFlW5rLNL9nuJF0C1CU5D7N6j9+1bguc1tDqHxapAB/ovbwqiGWBxg2WVCeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579634; c=relaxed/simple;
	bh=cHCUYkglDqNg2FuGOj+/CWfW4NUnhGwmo8XW8BumtK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhyYxuMkvjEeaCYfgAyLOO3nIVe2uoYh1gSahdcGA0NIt2juPJS56bE2w3wnxL4ogN1+dEMhd4E+6PNaqwHZNiqiCbLcgD+EPUvOXK20t92b4kT80y+JjtY2z6ugX4o+1YE68ZOzMZOJFmdIE4c01me+TNDQ2Mm2qnSixwA/AIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JSWPP1OW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39129fc51f8so1882024f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742579630; x=1743184430; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNqD8PyJLQnJQLvnULZ+vanw9dMkZAzGyI1k4rO3/oY=;
        b=JSWPP1OWCNSwL1+HWtEt3dmKEMwn5sER+T7MQKrdL+7FljOVciFGa/bTdSJppAJlA4
         YUCTgi+a/calz1yyGPf6O6n7kLNddubdEc4Fe4mUW8ckFG0EOpjx7RTs/GE3kQo30vus
         bp46qCPAfLGLPs+wk8qNP1NKx2L01EBC3LhZ8Wg3fJVkb6r5X5oR310xdF3msC6QV6w9
         k3RxTmMTeVnYx1MOE/jH4M0CQRMhYfxXkD3NdguAao/Q9TcdAmftIxRCckaOMC+h0liY
         5PxQerQtfG0htkFdBR76T7mmpwJHsVHp7fIYIlftlYy8RzLMOpxAwU5xz+G45R7TJ6Hi
         VoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579630; x=1743184430;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNqD8PyJLQnJQLvnULZ+vanw9dMkZAzGyI1k4rO3/oY=;
        b=Vz9+gB7ZOTOAZKMSA6UPbB/YNFLuYu8PsOoubl8iJ64P2x48FKOJmPYN44Q43vP+AA
         9f08C8Pqn8piiLX+gLyrbILRpmvlOjb3Q7htOTH5sx6nGkjx/hClvaFfYsATN7atFIHe
         bsZx29qI6SIfhvWkh2LpZHiufPpqXkk15eJ7T2KoZr1A2R60LVzO+YG78unwZR481ABE
         PYvAYtaYAkTQ/smNJK9rX7QDW4Lc/DpYVmSTFUZE+g+fb1t20kbKFbclRIFwep9yFhjq
         IkzzEd2a8p8k52l991t5pLF5Vnfc68kMHBsdaPetPKCr8IysUGzeaGGB7zt8qXddx7FP
         bDwg==
X-Forwarded-Encrypted: i=1; AJvYcCX9EaTBFYZZMXUpd2Ygy45o4B6+IkqtRyauVlNf8vWDs9y/w6NWdmLl4edwDLKIldBnLwyFhUiYGvGUfAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9Ue87n73crYXd1BLTY91iFmlGnSjcDpkhNMAjKXBo+JGYzmE
	6vo3w0crThqm2QCi+CJgXGIxDEykbwUaY4gws2UZlQsIbugtM5gfKaajKUSHv70=
X-Gm-Gg: ASbGncs9P8Eh3u+0DXifjPiFTkqfZ2WLhtBwRRpEaSMmC/dvk4FR1I/60NrIqUNdyfy
	kxD9nTMHMDnNYIAR1rr+X7X3GCSYt1hvT2X5V9dY0u9rtCsiv67+ZrafZmG9WRLf+pzqKC5e7zT
	B6hN3DHveQLow7NqqMHonsV8MJofsqY8HwhHimE1LldRi+Z/bprNJfgQMWaBcavFcU3fgNStRLK
	jGGKVwu18RLkuWRlPp2zNFIIjVZAUWAtNot/le3ynfFs4NrOKmTy4MaH3sthH1KPgF24tIT9ZEL
	m2e3puPfdI3TqT6Z1uKAO7aip+2JFy4wsReCjI2mVB/4
X-Google-Smtp-Source: AGHT+IGw/k1s3UhG3nO2rFtVFyriyvE9zSGonoM40r54Hxa67x+rs2qU6DUJGZCT59Otrl8jKGhlwA==
X-Received: by 2002:a5d:6482:0:b0:391:2da8:6e26 with SMTP id ffacd0b85a97d-3997f94083fmr4523621f8f.52.1742579630502;
        Fri, 21 Mar 2025 10:53:50 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:c5a7:dfd4:9ad8:1ea0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a31a7sm2929623f8f.23.2025.03.21.10.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:53:50 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] clk: add a clk_hw helpers to get the clock
 device or device_node
In-Reply-To: <508a5ee6c6b365e8d9cdefd5a9eec769.sboyd@kernel.org> (Stephen
	Boyd's message of "Wed, 26 Feb 2025 17:01:05 -0800")
References: <20250120-amlogic-clk-drop-clk-regmap-tables-v3-0-126244146947@baylibre.com>
	<20250120-amlogic-clk-drop-clk-regmap-tables-v3-1-126244146947@baylibre.com>
	<508a5ee6c6b365e8d9cdefd5a9eec769.sboyd@kernel.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 18:53:49 +0100
Message-ID: <1jv7s21d8y.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 26 Feb 2025 at 17:01, Stephen Boyd <sboyd@kernel.org> wrote:


>> +static void clk_hw_get_of_node_test(struct kunit *test)
>> +{
>> +       struct device_node *np;
>> +       struct clk_hw *hw;
>> +
>> +       hw = kunit_kzalloc(test, sizeof(*hw), GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
>> +
>> +       np = of_find_compatible_node(NULL, NULL, "test,clk-dummy-device");
>> +       hw->init = CLK_HW_INIT_NO_PARENT("test_get_of_node",
>> +                                        &clk_dummy_rate_ops, 0);
>> +       of_node_put_kunit(test, np);
>> +
>> +       KUNIT_ASSERT_EQ(test, 0, of_clk_hw_register_kunit(test, np, hw));
>
> The stuff before the expectation should likely go to the init function.
> Or it can use the genparams stuff so we can set some struct members to
> indicate if the pointer should be NULL or not and then twist through the
> code a couple times.
>

I'm trying to address all your comments but I'm starting to wonder if
this isn't going a bit too far ? The functions tested are one line
returns. Is it really worth all this ?

I do understand the idea for things that actually do something, such as
reparenting, setting rates or what not ... But this ? It feels like a
lot of test code for very little added value, don't you think ?

-- 
Jerome

