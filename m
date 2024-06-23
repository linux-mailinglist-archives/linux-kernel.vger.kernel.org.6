Return-Path: <linux-kernel+bounces-225966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03057913877
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78039B22F03
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B5A3A260;
	Sun, 23 Jun 2024 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8wHxASL"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5127453
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126574; cv=none; b=X7geyNr8m3zXyVuiECrA22RwEKrYXLIojQn/RHFhidvgjx7hjjd2H+qU5dILu6TtB/TzW7Pw9c3jGjhzvl9YQo9uo85JyQSxv2jqqW0vSCnoY0gvKe7GhC+YOmZmjte/Yqzi+rAtlUsahadd9szmZ1AlrLfkkKceki7WvAeVfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126574; c=relaxed/simple;
	bh=WJ3KFmLc/k7FTG7+QwYn33RecWwMJZxpIPOouYLJc/E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ktjuEFGQe5tmIKjUUdWnKm8MAvYkrMNb4Lu09JV/oIjV6Q9X0CRcna+z8eP8x4mqo4nUr5XkcA+FF8ndsDHkUNnXSXc8KLqjwSGTcnYHlVEao7mIcK0Fjjm7oLn7N5Fo9SEFlYp8Vy8wMcFEsGPvrZhfbY1XSsjsnHqMKNr2fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8wHxASL; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25ca30072eeso1745712fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719126572; x=1719731372; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJ3KFmLc/k7FTG7+QwYn33RecWwMJZxpIPOouYLJc/E=;
        b=D8wHxASLy4goTkahZ8hfURlN3iAkaVNMNpTtBHCWnNyXVwy+xpIekg2PnY1APKGn7K
         J5Ky7HD1gjN0Spqkmdhpukqw5JXKvaSJx3xGiM2injFIUyFW6pUlkPDEF0XDDw6YIEAR
         ht6ewBg9pPC3WmOx1OmFN6OhG7a7Zu6vOwRD4CAX6xe7cg05efz/fWMxQpXDHlgfxTNV
         73MRKi5n/qen8xF3jL1GjTMMN5ZAz0St7yystnFx3GXQevSI0Gpa/dppWd8be1h0deX+
         7WHYeZ0ojzx73s/evbGqnBiLjpU55sK+46bhLcv+3Jk+jVs9IH7GjZyg4/TSvpoyGBgT
         4Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126572; x=1719731372;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJ3KFmLc/k7FTG7+QwYn33RecWwMJZxpIPOouYLJc/E=;
        b=RKTxNpONh44VHsaGc+Dl0Gpk9V9yKjXOSfiYA3mbaeiR63cpCmtjRDDwyeoVw7+awa
         LI6MPf8TIXXtyxAexDo/Jp3+1d1xY29nIXUBB8ebIhW7KCu8MALueKqXqcqzD7PJ1DmA
         vnzZpx8+gBOhHz6MVjSLKSWAbZ8ZgwIWnminMAGBXwkJDFWnFCxRGFt6sx31opvChssp
         8ulPkrbXZkyB1Fnlrr0H4GxjE0P9y80PIECGTcfFyx5Ph4peCUpDRdN6j0Nv5wL0a3uY
         KPe+uAjih70LHeXSzDsBQYZM87ChArrZgQbsSRR8JxhsuhmwzRR9+PEoa7uE4JhlNlOt
         Ii4Q==
X-Gm-Message-State: AOJu0YwOkSVQMTx0MIBbdSO0MItbMD/8tjUW/HObUCLx2czr/TFCb0Kp
	txArpVFPnsvTXx1uwEIOxH2whtm0XZ3y5Y/PnsB6aOgSqAiyfNHURf+qasB0fjYxa6FmYuDRDHe
	i0OFVvypyJzNADcvD+3JYQoH5ORSVZw==
X-Google-Smtp-Source: AGHT+IE2c9F8byrJg8400fkmrfx4VyKUZBa2GpK8/7gScb1D9DtwxoSI9AjHOzc3ELKmBMwd5aeg0k3ZYOmjoJ4nsl0=
X-Received: by 2002:a05:6871:3a20:b0:24c:ac7e:8a5c with SMTP id
 586e51a60fabf-25d0168fecamr1963689fac.21.1719126571980; Sun, 23 Jun 2024
 00:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jon usenet <usenetjon@gmail.com>
Date: Sun, 23 Jun 2024 00:09:21 -0700
Message-ID: <CANQ3q19acqJ5BpseEukYgSHiKiSx42974rHnU3wKJWr3_EV7_w@mail.gmail.com>
Subject: some tips for the linux kernel/modules for kernel
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

1. global data structures and functions (access the structures
throughout the kernel)
2. you can define a conditional with multiple statements that can be
reiterated with functions (ie *p = _malloc() ? rSIZE(ret) >
kern->page->size : rBLOCK(ret2) < counter++ <= kern->sys->etc.blah();
3. one big global structure with all the sys structures
4. loops that call functions and execute data based on a global
structure (see 2)

this is great for module programming btw

have fun, also amd threadripper people, try make -j1000 (seriously, my
i7 compiles the freebsd operating system in 2 minutes with make -j100

