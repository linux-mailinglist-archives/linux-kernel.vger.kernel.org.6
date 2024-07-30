Return-Path: <linux-kernel+bounces-267761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0294152C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A382850BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6C1A2C20;
	Tue, 30 Jul 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs3bOmn3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F419F460
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352325; cv=none; b=QjX4xMSKlXceFRQsccJoJpDKIRJltRyISaOND73UttWA0MznVLQXlNI4xU1wL8DFjkzb5LEuLSIyAoUNlkCKl6+n2O6nk60HMU9eB/CDj6FkOpi6GfuL81B/hK1Rlotg4w8nf1dsWzosLIWe5vFmcg6y42slioS1DTMN9vxNlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352325; c=relaxed/simple;
	bh=64gYgBWK9ugIa6pVhNY9QfhbaHeHMTWhZRaldjBCEio=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sP9hw5pvxYOD21kV31O8C5LstH5HZPDWrLTEgZDb5modMcUmAk3bTddU6cQIfFTA/XSdnKaQNK7i1Vs+WYo2mxJ/HNI+uBLc3V9ha5QMnGoUrrMOsFVdKV4f0Y4Uk55h/+ayqzF93LEkPpD+HAeAbjMNYU8DLQeFxHgJdB+pqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs3bOmn3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so7399002e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352322; x=1722957122; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QtGSwj64K9f6zt/7404m/ZCDRQDneW0za2GkrWLVpGI=;
        b=Vs3bOmn3zDxj4WnwteQncAMg6Jdssc8vH5BA5xZM+x1KcKtkMcSW8cf3xDLrHeBBi9
         0yVdbOxnXL7Xo9UTAycUORRYP5KUYCVVN+cU1PLXZ4AFlSiY3QkxVJW7iTHDAK+M4rHA
         3nVIQhZboPmeMUfRBpWpRVLO/ComuN2APjNVo1mtp9vHMb5WdXeJaHr8R3LzSLITQhNM
         Kl/75jDlqTz9umYhKZNLLmFX0oSbPs0GiukYpa2aF+mMmwkJ7rZrCyPANCwvTiT2xzrk
         sZsDzon+7VbnA2Xn7Ueudl6rQoaIxHpXLfCnzZvsew4J3h7p1xT1w8yQWPVihu0Z9592
         Dxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352322; x=1722957122;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtGSwj64K9f6zt/7404m/ZCDRQDneW0za2GkrWLVpGI=;
        b=Wmf3YyyavAys7M0pOFCa3RyzcybI4Tc0VjsRk8FFJ6XUPqO4Bww2dsRcaLzIR/xaZu
         dEGvB7/xF3oLRju13w0U0rSGQsMKs5eUrGOVGYK2YPQ7qYYwka6CAkJjTWS7pMLJOG4u
         VFXeSlcGrzBYV9oh9g69Ni/BnGqVseDmizIHX3a0OYei63JzFNQoQO2qQOYvT/OheGtK
         +MJ80VkKzW8MwcMVxzH5U9g9ncaIS6HtTTvt/9f4XYfhMKDmff20aPFH5IMumz9yT5n+
         7lm7N8m+P+ie2h+mcQLTmFVD38DsWHCimI2ig4x/5C4KkraJcdsAFkbi9D3h4hxFqdif
         /FKw==
X-Gm-Message-State: AOJu0YwAscxDJQHbLLdFyU7bLQ4vRk/LE1hJhojFiW5+OlO+xK5J7Fzb
	pJv+F4Z+xkj38xPqBYnYuuRIUAhBDQ+byjZdT7yVY3wWf1RHprzr2jc1mo/knScB2CYmM9IzAP9
	uzSVGIHnCOYuQGxOMV77oT4uhZJHz4g==
X-Google-Smtp-Source: AGHT+IEbnpXeNctrxI/dzpNTpcYvr56zkY22GObrajQ9EKcrjYwtcWHPYQ/tPCa8hgJwdCtpYmsjHurZXGmUd4UCjn8=
X-Received: by 2002:a05:6512:3196:b0:52e:ff2b:dfd8 with SMTP id
 2adb3069b0e04-5309b2e0af1mr7559056e87.54.1722352321837; Tue, 30 Jul 2024
 08:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 30 Jul 2024 10:11:50 -0500
Message-ID: <CAH2r5mtNqn0i5NQSQvMvbHDdRDJxcNQh7iTj76L=90kEhDA7iw@mail.gmail.com>
Subject: Problems with suspend hanging laptop on 6.11-rc1
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Has anyone else noticed suspend on 6.11-rc1 hanging the system? (I
have noticed it for at least 10 days with mainline ubuntu builds) -
have to power off and back on to see anything on the screen after my
Lenovo laptop suspends.  I did not see this problem with 6.10-rc
builds or earlier.

Any ideas about workarounds?

--
Thanks,

Steve

