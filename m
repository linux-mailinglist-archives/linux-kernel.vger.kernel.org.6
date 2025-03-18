Return-Path: <linux-kernel+bounces-566118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCAA67369
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B773B6C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A141F20B209;
	Tue, 18 Mar 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbTLrSD6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4291DD0C7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299428; cv=none; b=H741/x6WitHQEIu2aXNA4fxXvYr4xwvmL34wU988W4WEuQ7t1sisjku1jYRjKnaKQN0ANsGocvgVUfmWn2p4txhFyh7UUPqmgQWhQrkOtYUYcUYY/qEIoNo/r2PLFdErEQvzMxFsZCQtquPwziZn6L2GuTj0wOpcYwcpbmF8vto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299428; c=relaxed/simple;
	bh=r9W2oByKMjCUexc+U6zWTeAxEfds9Y3CGAAEJo7W7kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSK4O7ygEMXeQHc+2Zsa/1j674VJv9QomJwEF/tWG9vZisa236wmCCUu9argBDBi5HRapx2FviEQf0DJxNmQbkmnI0iax94OrdFjKMJpEE8dISNlm3dGfLvyDzfhr7ruyzRapqVvYyVCvKWno1LI7FDCAbYn8rd4CeVq6Fj8WBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbTLrSD6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4741376f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742299421; x=1742904221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EIvZ3Wp+90RhosIdCp8kn3gSMcgQFE9Tp7I7nCfwJ0E=;
        b=JbTLrSD6rcyk0Tvz2JPLTKXj9kN7vzhkbj9R+pYYpJyhgizGjU9UREYU0VwnTyKHBC
         YDu5DMjV9NMqrgqbFXRkWUVIqBxowYo9UVenN+BHyQJIuiUYD0cwB8vpNYP2j33Rp088
         C5tq0qkFOvYI8z2E15p3agM5pYfU6JewIIuMIe9GsZZbhFzmjb1PX4/1quhDxGaGrwTQ
         BoQvCQMLxDAn+Y035nfJ8Jd+tbCxOBURAYkAtoajCYbvDEDENTiXpvG/a7L1vMcU5adA
         PY2ytl6YL0BjvLyn3wNSffmJzr8kNJiNjDzqJSJ9AHUppmKYTVA5/gqM6ZU/bp/WWC+E
         U76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299421; x=1742904221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIvZ3Wp+90RhosIdCp8kn3gSMcgQFE9Tp7I7nCfwJ0E=;
        b=nxvSGt3m5YGN/4dWYryN30I1j+RW3DT1ZRaE9TPasK7fityXQzaLOIrEUjYiGl/wWD
         epOVy3KbPIOoycQn6r/89AcdlUK6gXwjlh5hlKavl95A0fkCg65X9+Ba9aZFw97mbhyW
         f1rgqR0+gq3iHQ4Ia/5aJW8JKot8tCWMFxedH+ryLGn0gwFsZQNGf3OEvpwN0jh/fDqC
         09J8eIidInwhtizyXjY6GgoQ/zRDrP3hac2Ugvq5l9bFGNMl8hDm/GXgeTjTozz5SQ5O
         uqDnJACsBY7pZWrADKPACXnGVNR1hrfMpADQnkkvDDY3g6z5MWnInqhnTDxdIrmkIzWl
         pgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXN61yiCns4lZKrC33cXmRjR6XDCf+SCPqIdMX+skr3g0NfJ8mT4+ghQcKgluJrS4V2MbjzmJJdD6YVV2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUp15XCqk3GFwzV3lvOr9fAOXYt2GnU9IXhnBj2d1pEw67rUU
	SSsbZ13rUvTfxv8eHcvuqD+9fhUPBXZ6YuQxoVKet9SLpqFcwcjv98/QGcZHcMsAMpicV+AKCuz
	l
X-Gm-Gg: ASbGnctONIe1oEggBBe2euzr6RsMi2i0cBUPznW4kkUZCpVYdgGNcDYkVXKUKVJek+1
	oUD3elM/mi3FH6+M2rSJmPczhICtN/AEAwvkhvu8qtjhZw2rnvZTZ8reCnMIWdXNdlOHct4zSav
	msnWX7OeIrzn3Xicr97viPOWNg1ZlZ7WJMhY80DCY11WhMtKIcO08N1SJtjFf+dFIkraD5JhDDJ
	vry0c7eDbBM+JRkCB9+8falTRXcTqjZJT1LVi+XQjtCpJpfWUUWBfPQJExblsAC8OT2xE8F/box
	0V3icfSeNcTeXM6yK0o5YDvZc8M6Mi9ePDBc7RVtgtSdA9dQHQ==
X-Google-Smtp-Source: AGHT+IFpsBv5twsMP6fmrTzI785OG9MT2p6MsEQHUu8xAsUGZO1uS02mqQn/S4PSHW3veon64U20Lw==
X-Received: by 2002:a5d:588c:0:b0:390:fbdd:994d with SMTP id ffacd0b85a97d-3996b47cab3mr2750146f8f.27.1742299420841;
        Tue, 18 Mar 2025 05:03:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c8e43244sm18330917f8f.60.2025.03.18.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:03:40 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:03:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception handling in
 cfi_intelext_setup()
Message-ID: <7eee35fe-0d88-4f38-b381-1ea2ee4a4715@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
 <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>

On Tue, Mar 04, 2025 at 08:21:53PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 21 Mar 2023 20:13:51 +0100
> 
> The label “setup_err” was used to jump to another pointer check despite of
> the detail in the implementation of the function “cfi_intelext_setup”
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.
> 
> * Thus use more appropriate labels instead.
> 
> * Delete a redundant check.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Don't use a Fixes tag for cleanups.

regards,
dan carpenter


