Return-Path: <linux-kernel+bounces-339452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB75986545
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42071F23CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05704644E;
	Wed, 25 Sep 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d4IbJdFl"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36E1F94C;
	Wed, 25 Sep 2024 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283862; cv=none; b=Z/TXSnxbkzNmfiKl4RJCujPlyuwKLBwybF0QUTEDSg0u8gu6ewwAVjkOXQgHqeC3aUT6uzXyr1L6uA6Jx0t20tBrCEYnD61P3RAQMQEfMr3cZ4pr4eNXEMyUMYQojIQ/E7mQZA/ePcGZb1kedFI/tZBu4dSJNGEOAi4U7TNj4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283862; c=relaxed/simple;
	bh=Bq5wCmhzzuQ7d/iEftzkFjM8U+0zxxmrIHVD5NJD+uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPMJWNWSZQpg2e3tvY+pZ9pj/8kZyCs3ygCPrhO9cpTP0VFoxJzmMzMPffUJ6sr35s5Jnd0y5SjTHvR3Lpwa5A9TJefwqhK3bLD1Je3OVS6X3Epg/zHa8WEFdzTkVXuXJsZ8S45Q1Or1jVN7XehC0zahLt3wxYzUM0gvC3Taz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d4IbJdFl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208cf673b8dso79535ad.3;
        Wed, 25 Sep 2024 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727283860; x=1727888660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq5wCmhzzuQ7d/iEftzkFjM8U+0zxxmrIHVD5NJD+uU=;
        b=d4IbJdFl8kpehs+eIenEMBkwAESQ4MWEP1k8EMikaAAJ0Ba5Pa7TfEjFCmVW2NvjLr
         tyBe/oRPCJ+laxnZQkI8Tk8KHaWKkXGhw6WZxVgiHuRiRJ6gGSVyke9a13k0lSIG8skz
         c63TRPS+5d8PzLslbw8oXqUXe+944FRo3fpCV7eHfcFrDRtXKeCI7XphfutFHrr2X5yl
         utIuvJW7XpTwMO0c2mrwPJTHE+d87GU9H8G7Yn/C8FjizNYsxitVptmZlqIwbRtyzEM6
         R5kqeuQE25I9rm+Rgr51pJ1MZ/kSt6DrpD3adKFEFTj0XI8TIFwO2lnbJKCemxsqOhA7
         d/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727283860; x=1727888660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq5wCmhzzuQ7d/iEftzkFjM8U+0zxxmrIHVD5NJD+uU=;
        b=fSu6Qab5bAwoQXTPUrdLgKf/DmV5/zPdMbMjAmO/YhOkJDptvpSjBrFIz8aFUX+w07
         HCFrzBVTYkiVcPTBVjaxmsY3WqgMdFh6vyRUPTONEa/7OJLzmqoaW+MMWINx0Ga2pqSr
         ySHtfvSl3yPw+XoMJ9DlzdOAB5eA6qq/8VrjscrZ/WY+FwGG7cQ5Y+QyrTmZIPbcEDW3
         pQoKfO4Z/0birrf0s88JLVdMStaiH3qoL9UYVP/89OiG1ox/fb5r73VVjyKqvOXgvhDC
         pVhN3oT/0ud/H86x3UfIbG3EECidK8bMvWnmqTFPx8rrwlBtEH6Sw8bQt6bmbvoOX+Z1
         gtxA==
X-Forwarded-Encrypted: i=1; AJvYcCVYXM3bZ5/24oICZEd2wjjsbCJsV8XQjfkvgWkqRI0d0tlZKJjml+8XcwBBOVuiIuVuZOMz8+fHPao=@vger.kernel.org, AJvYcCXxZEfvstbxOAdgJp1oJceQ/MLvraMnS9odugfk/Ag8aP2dMswo33hVYwdPAOO4Xf7Vbxil8zB8IMo5Ipab@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6/2Q0OKDvlF9a4lZZPTfTi0Cm5sXxM8z6d6WVHRt0TE/uVN+
	aJ9GocfxxBN4wZAdr9WdAOZ2iGZEvEgH6t1FxTxLbRhi8T7v4N3EmgTXoIlBlpeNd21jeOrCgwR
	eY/Wjwtfh6stSbwx90zPDuZXcepxf1yQv
X-Google-Smtp-Source: AGHT+IE2KICxen3r5RdUuJO0lNZf+001DnRTeqMDIWxZGbegnH0vvIeIp8h58FVyHhO5R+jUC0ikKFeuNZleClYHXmM=
X-Received: by 2002:a17:902:f54e:b0:206:aac4:b844 with SMTP id
 d9443c01a7336-20afc400e57mr56364895ad.6.1727283859982; Wed, 25 Sep 2024
 10:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925-clk-meson8b-spinlock-v1-1-50b7f2d02d7d@baylibre.com>
In-Reply-To: <20240925-clk-meson8b-spinlock-v1-1-50b7f2d02d7d@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:04:08 +0200
Message-ID: <CAFBinCCMzxf-pskQBZRs10CRczYt0t09xS9Urpp6Cc3cyu+8jg@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: meson8b: remove spinlock
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:49=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> The spinlock in meson8b clock controller is now only protecting a call to
> regmap_update_bits().
>
> The regmap API already has its own locking system so this spinlock
> is redundant. Remove it.
Thank you Jerome!

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

