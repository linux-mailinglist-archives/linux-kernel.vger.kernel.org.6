Return-Path: <linux-kernel+bounces-339477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2429865B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0A41F2166D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3786252;
	Wed, 25 Sep 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e9pl/eEL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB71D5AC0;
	Wed, 25 Sep 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285667; cv=none; b=PNoHANRf4cCfk8ZKR9onwa2SXsSvkVzfCwZw3kF0DpUp54PNOD+QQX++za4bqN3nvJad9rinDCr7PEwMAMGAsISCWKc4VubPmmiZE5aQoxWnfKx9i3d4hSUR7KJ9pRuPSXSxtMDbjuxdnU/f3YcQjcGA2jdMn/dgQjUw9y1L4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285667; c=relaxed/simple;
	bh=d1E4RT0H01/3XOdkjcXImvKyDWlOUp5njzyOvR7rg/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp20xdt/IYLCYx+cN/O86m1u145UiDIa4VVqAC4cwcV+9dv4vQOjdySJKrl1qR3w+hb65oGkXflFRfORM+R5FRt1FID3hesvu6txCXdRo1ofDHc7pTT5fEHaIThzuR41Of2J4errq4jtS6yNS2oUhmZP/gVZHK8F5WeYzNAnmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=e9pl/eEL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b1335e4e4so573855ad.0;
        Wed, 25 Sep 2024 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727285666; x=1727890466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1E4RT0H01/3XOdkjcXImvKyDWlOUp5njzyOvR7rg/4=;
        b=e9pl/eELjyPDkf67z15mzPXP+xkXlmRFcHx4ZNkKt1iodsEPKLRzX9cQZncmtKS/bq
         RVrkElN1o6Thwi/b3bQtAyjWcNXLYzp+Z8+Ns45ayFrd3e+IlRNYHaJS8yHjeeakEKum
         KG7P17KrNw9yiqUNItDctrkQW089ASCiYScug0PF8Qn4pZVT8iqAa5Rv+qmWRWulfOFN
         qnqH6wtAT6TsAql1xEP9yuHtQXBIIGo9FqvVUxzBez4p2w91XqdJBngIbxEyej0EXitV
         Ds007DrWWIrcF8gkgd89E4xMkk0okw8tuEASNBvheFJCO/J/z+aktMw6dhkf8drIr5DK
         4YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285666; x=1727890466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1E4RT0H01/3XOdkjcXImvKyDWlOUp5njzyOvR7rg/4=;
        b=Lqbu1+m2eWAuCf9YwQIIM+4Vg+I4dc9S6ZLuTSWYmyuM9yU1zeDf0e92KymJD55zEO
         gjf7l+WK/t2iMXYtm+5y67Nwo5NMKweKLL5Ymd04bzltNci0lrTW3VRWEzsc3uC85Q/u
         19yKfgOGV06N1w4SdaVTVKA6u5IKDSMyiMIcJJezh5vN+B1cMMZJ0BTjKEYVCVCmOB0x
         pYCo16YuriOnvMHUZY4MO9H8+TpYYTqnW1IJRS0hBUuiocLv+xsruPUzZmDIqK4dQzAa
         pBBXjpOyBR3d2JuwGg+qoYXBhK5QY/lHdw1NvjozEgjOvXex/u9+7I2JZlGnxWAZ0MU/
         XoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlNgggXxH8+wlRgtW1R1nUN3SMKag180bXmC0bVvVFDij54yNnMGpN4BQ2jqXAMBmI/iz2WQfKtf8Z@vger.kernel.org, AJvYcCW+FT1XLozCFjsa7J1Ck1A4Rfmuzm8NNxsVNfElaQOJzfTh8fg2XpyPmukBr4hZm2vBkI6TdtvY5hGcCSnw@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQDg49F+L04XvQw/AlwQMyb23BZi0b2D0otExPLS8d3hgRoY5
	3IyP6IDTnZevuTqTus6igYh7RH9zZ8/lGZ53HfRJiMAvYzqxlmFDkt3pHMF9w2V/7jcD6AThMLu
	Ii33pGd9Tl29WT0yyxSRiFN2Wzuc=
X-Google-Smtp-Source: AGHT+IH694n5wEuALNHctrwi3lZcE5YKzgjYaWIr2csNfOXbQ94OBeuiNlhEeDltpC2ncyhruZFRzQqtChN0vurPm3g=
X-Received: by 2002:a17:902:f788:b0:205:5a3f:76b5 with SMTP id
 d9443c01a7336-20afc47d818mr43818595ad.28.1727285665891; Wed, 25 Sep 2024
 10:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-11-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-11-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:34:15 +0200
Message-ID: <CAFBinCB7yv+RDNmAwXEspyaqXw9CkHhOq=bzFTU+QobZmz6pOQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ARM: dts: amlogic: meson8b-ec100: add missing
 gpio-line-names entry
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:08=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The EC100 gpio-line-names table is not the right size, add the missing
> cell and fix:
> meson8b-ec100.dtb: pinctrl@9880: bank@80b0:gpio-line-names: [...] is too =
short
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I've been staring at that table multiple times but never noticed any issue.
Great to have code in place to validate it :-)

