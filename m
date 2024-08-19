Return-Path: <linux-kernel+bounces-292770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543D95741B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CC8284A92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035D1D54FA;
	Mon, 19 Aug 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0gnNYNb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A611D54DB;
	Mon, 19 Aug 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094346; cv=none; b=uCFEYYUmS9tnIqH5qzyXLPryxqVuPVrnwLLambVb2IGBT1E5ftlK48l2u+Ox+G5pLtjF4lRyu0LwzzSBA+dmiJJaLwSt3JB9ZsNP42A3vz/DJdExf2VVQbahV74VzdDPniWeYeVLVMCWSt2YaM6O/QBTCeLbJdkT9BY0gJSQza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094346; c=relaxed/simple;
	bh=k2A0/BCns1Cq5J08fexRX14OJbjeeomB62tUYjHSxuQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Eyb/0mH/OA6QrUmJwYbulxA+DfsM5IObpqUV7m7udAYNuWbLOhoRASvamCLT6+a0tbB+GVUgcIMmIrKpmgZwXlh4a0x9C3XEYovtaflxsmzWTgaKaOGuLEERFd8fhBXcyJUS9w+ik/KDFmW5Lsc6jejqvzgDCugbwlVJZ5guIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0gnNYNb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d394313aceso3553538a91.3;
        Mon, 19 Aug 2024 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724094344; x=1724699144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BSA8WlviUSbpbuW965c0ZiyQiaz2MAchqTQ/6QUBORM=;
        b=d0gnNYNb+3VmX73Bz42ybtvvcVGKqlZ1HbN7Dz8dPfYsAeDvWPQz8CoGDkWrvJ+Mgc
         /Lp8e6+7ai4rkP19hFeR0pCweoIolYlPUzVBZBCjqUp2+yy8W0FeFWsNh23ZVjkYhzGx
         E4NTvuIWK0UVemEjo14QmdVWuK+qn/wCbbvwvq0bf4I6ebhwR2gaXKL9Xujjudir8RIG
         bwidYLjm2Ivbmtsj/Ia1DI9Gu3YjW94CHwBqboVhNQsc30YIarrfspwg6rAQ6aCQKVxa
         asiXp3H5toI5DOOymGszQUkcwCqiJIlONMJMXD1FV9hh2BKO7nXUXJZ7pNPg0wjwwOz0
         PIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094344; x=1724699144;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSA8WlviUSbpbuW965c0ZiyQiaz2MAchqTQ/6QUBORM=;
        b=kdvPyKT9a2NziDpczCX8JrkasVEgNSEZKkHzLAYLjdJrEZyEB5mUksNvbbksyQlgwv
         MakmMuvZm4jW6OIT+lINsiHrTwCEpr9JutRAIfHpe4Tf9DEdtr11jRrJqmaMRW8+dyrM
         TCerMzJtvDDEmmrTrsRYluziwDOxSlveSW7z6CRlpahquPr2DWzK4dmWCRLyFJIre9nP
         q3FswUg4PzvytNdm1RRaADrFYeSpfSXuvJQTbabE0uhPwBij6cyzlnvDaPZPYhO67p+W
         drT0d6ov8mj63qdJvqthTTxngnjgU14+JyN7P2k/IlUOl6gJdHvXpsyk/JBWVrNMLeuo
         KIqA==
X-Forwarded-Encrypted: i=1; AJvYcCXbAyQJeB3OAjhqDYWHXssGIxVOeJ/4azxq7rtB8A18h+QK9pD3bxAt6YEp78esTSLNqKMFWFMOd3/ssuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweu2d14VcJF6t896j15DaMucqFm+VUQm63h/RPYbksM1lnjlEM
	+82VsBVvPWP8YAdOhEAFRvRRyeEB+GOP6QizX6LLJUCRd67R+mI1faWGUrN7D1ZXWgZq3nt/fls
	baKh+iPsrfcBSjlhVfRy3UJIAaaQ=
X-Google-Smtp-Source: AGHT+IGa7rr0kwnXmfTYxd8zSa33kt45UXDVPxk1ZqIsHO3MbpEWRryA35+GhGrtpPQMyIndwBWIp20kyw0pU5lyPz8=
X-Received: by 2002:a17:90b:705:b0:2ca:7636:2214 with SMTP id
 98e67ed59e1d1-2d3dfc2a217mr12905753a91.4.1724094343237; Mon, 19 Aug 2024
 12:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Mon, 19 Aug 2024 12:05:30 -0700
Message-ID: <CAPbMC74ShG6R8JEoiv29082GqN5jbkHrLcsw6fXfjWu=oAqmAg@mail.gmail.com>
Subject: [drivers/clk] Question about `en7523_register_clocks` func: misuse of __counted_by
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for COMMON CLK FRAMEWORK,

We are curious about the use of `struct clk_hw_onecell_data *clk_data`
in function `en7523_register_clocks`.
The definition of `struct clk_hw_onecell_data` is at
https://elixir.bootlin.com/linux/v6.10.6/source/include/linux/clk-provider.h#L1405.
```
struct clk_hw_onecell_data {
        unsigned int num;
        struct clk_hw *hws[] __counted_by(num);
};
```

Our question is: The `hws` member of `struct clk_hw_onecell_data` is annotated
with "__counted_by", which means the size of the array is indicated by
`num`. Only if we set `num` before accessing `hws[n]`, the flexible
member `hws` can be properly bounds-checked at run-time when enabling
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE. Or there will be a
warning from each array access that is prior to the initialization
because the number of elements is zero.

In function `en7523_register_clocks` at
https://elixir.bootlin.com/linux/v6.10.6/source/drivers/clk/clk-en7523.c#L428,
we think relocating `clk_data->num = EN7523_NUM_CLOCKS` before
accessing `clk_data->hws[EN7523_CLK_PCIE]` is needed.

Here is a fix example of a similar situation :
https://lore.kernel.org/stable/20240613113225.898955993@linuxfoundation.org/.

Please kindly correct us if we missed any key information. Looking
forward to your response!

Best,
Haoyu Li

