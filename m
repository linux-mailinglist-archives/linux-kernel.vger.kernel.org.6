Return-Path: <linux-kernel+bounces-430582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4EA9E332C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0314A280A54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D818C907;
	Wed,  4 Dec 2024 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrJfiZ5L"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990C18C900
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290495; cv=none; b=MgTCKpRm8Rw4b0KXAzlOSuk9J2/Cqcuixv/34DRxjyHt6cfSn2vJFsh+uRBBaMgwvqLUfgk2hrBRDMhjekHM62WyyeqWIFPQH0/kI8ZqdJ3tuX26q5J3lXm7Ub2ktPKlxwGMXMV3nbD5yluJzyhJoP9Um/pEZ9phv6mqLlydn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290495; c=relaxed/simple;
	bh=60KSuMbH6FJbeDv6I5bGxnhrCC3u+PsWw6p07DCkF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZB9nC3b3wCTF51Z4WxebCYj3WhBON1uuxdlfoCWYvJ28ZNlKLmJyUrofQrZpatRhtYTwTTz4xrolKE7WSysMvMNhzRSnbNV9xP+3cYP7JNbT2gVpcK9ikabTcGj/N5Nw0FaO4um4OrFEgWJdfTR09+xw/7zJQccsdxbYkOIdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrJfiZ5L; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso407455b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733290493; x=1733895293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpAS+t1areb7EFucSGZBUfI2eS3KNM5K70k5cIEXvlA=;
        b=IrJfiZ5LUzrAYwNpi4hA1nvCctdopIUfFSzb3cn0VQu3jWuoJG2j0fMA0XuL6Mnn2T
         MhgDlO5r+1+JaVG0KlqcdMB7gkuacamDrtCntc5Bo/dj0+rprzDoVsZsruo768QiXK9d
         5ZcmtVLkBUYAMZ8lijhTxm89ZMsP+daUkAEHXrYrouC48YmaGt+YlFXcHAsx7LkezRWF
         JGLKD+6YHxmu3F9GiwBOSlVsa5kXDiPuhIs/RawaTw/b3efFq+axwnowVeUlfGgCwNh5
         FmJcJe8GsvBEEjSV76sj5nr3WZvl8wPpFFZqaNQbjYFUmppnWM5GpauyPitT+ekrxmTL
         RY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733290493; x=1733895293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpAS+t1areb7EFucSGZBUfI2eS3KNM5K70k5cIEXvlA=;
        b=RhlumUcQO+rOplmRlhI0s0m/z/Vm9d5G4z45/Zlit+uNzrCbqeYBem8N+vFVJN6ZQa
         HlQidgdUCGpg8NLA069x4FmmWQ7Baf+rgdE30RamYYI5C7oJ535RnlNQjfyfF28UFM4i
         qadPISgLEqIVP7HUjiLSotz1p2TFt93bBTFUACjSB+XlztAuYwzbisGcr5WYl9jPK9sD
         cBJJ6riJJ1HClo04U41kd+RPuL4JRHzhpJSD1v36/L0xo8l4GlwppWfqU8pZtAo30RhP
         yuckOPxI1kzFhrNmbLX0Co9XoeM9G9ppFK00Ea+k9cVRPNcGIPbNX34ZDIr5e6MG4eKY
         Zxfw==
X-Forwarded-Encrypted: i=1; AJvYcCWzASRaSNPPTWKQvfe8kupQwSPVSxViAxgk7RewwiKdj1pdLWy0/X2BDSi31Gm7nis4BCEJlaJ9Yz3KoxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS8gjLEra5/SwBpjvOBRxhoO6P1RXVi+6s5cOLRhdcV3SxrdX
	uSJE1fFmCbXpWiboEUw60fgII9I/OGYFcrfgrrgd3ATE2qCUIujVA2B2cDlau64=
X-Gm-Gg: ASbGncsiq1VeO3tH/zcxwqD6PMFXtwtKES3qniB+WMed9FqbVTaEFayyUGgKrEkiKke
	t297exIphqzoixnMRnj30gEHBY//g+hVE3JXuEFcc2XlZGGOi0CxOVpazbCzN0p3PFuD8dTUUEn
	fjdbKwpfESpDqydyomcfrhsMMMTqEGSLPcysFtQpxHaEQ3ph+OJLu2QGPCivgBGj6QDAq7/Jowc
	86uLVEHhD0ZBkK4u5nItuCxe50CMBDS+Nf6OAFtVLzDIY3q+jso
X-Google-Smtp-Source: AGHT+IEdnpORya0TLF8tZAX1V3RSME1H2AVwMfeTBLSah1wfAtXBdmItialQ323eREnRlYZm0uWy2Q==
X-Received: by 2002:a17:902:ccc5:b0:215:9d48:46f9 with SMTP id d9443c01a7336-2159d484a42mr153610715ad.21.1733290493127;
        Tue, 03 Dec 2024 21:34:53 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f627sm11823857b3a.64.2024.12.03.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:34:52 -0800 (PST)
Date: Wed, 4 Dec 2024 11:04:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] OPP: fix buffer overflow in indexed freq and
 bandwidth reads
Message-ID: <20241204053450.hw5eeqbjovwb6hlb@vireshk-i7>
References: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>

On 03-12-24, 09:12, Neil Armstrong wrote:
> While fixing a crash when calling dev_pm_opp_find_bw_ceil()
> because the bandwdith table wasn't initialized, it happens
> the index is not checked aswell for indexed freq finds.
> 
> In order to properly fix that, pass the index to the assert
> function and add a specialized assert function for freq
> and bandwidth.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Use unsigned int for index on assert callback
> - Link to v2: https://lore.kernel.org/r/20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org

Applied. Thanks.

-- 
viresh

