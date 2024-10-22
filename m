Return-Path: <linux-kernel+bounces-377078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E39AB991
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D745B218BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657E51CDA35;
	Tue, 22 Oct 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AX+qs5pk"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35F1CCEFA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636824; cv=none; b=Hf5hUwYUqTCbBn3N/OeL2Bl+fz8oDs5EVM6KlkZcuPBkWzm8FjJzLasP/tTmoHPopzyL+d+OloDYCezWE3W/VJLOB9YHSn3GBQyuwm9IV1IETbKTGQXQB2Sggiya0DKHLTVGZm7bGCr2yCoQrjqNNzdaYPh8belyxkiviU32WXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636824; c=relaxed/simple;
	bh=lIRTsB8/7w9aiXGwumD/5t2Ntq2v4lrXMrKQWp3Dvbk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VdHh0Wvxga/rJqhSlr7dCF64a3a6P1mYJiln+GrGzYOpi/RFlwXsX7VKfekyhJpN8KoIr9LoUBu99BJnQrNlfcY1cfVt4Xuxlvghi+u0o4LH/vv3nhTczuyraIKGqG7h/Vv8gjm54kDtsllnmtBVQorsuBYIE0TT3CXt6Eq/b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AX+qs5pk; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so6010704276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729636822; x=1730241622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Ogz5IrclLTw1aKz0Jr4sQzXNdx/+9D4zH2hrfc475g=;
        b=AX+qs5pkC8iLWioSeNcXJsbZHQZos14yxFPXunaQBtu4utumfK0EO9yRl8wuzfIR2V
         NGMIRNxBd6+E+i3eTVfewrdVuwikgl/1w6OZ+f6rm8EeF5ltSZ4UAqzB1O5fRYz4Mu0a
         KU/fy6q3B+DkZXTVyZs5+dvY1XRHyIYIGlUPXyg7Z3Ad4rZOo6znvtRgEth8DXJmqiqY
         O+FHkWRwDCUGJz5KyDUuT7gER//hStrHLMDkQuXghU8Q5WwvO7BzHaX/Lam3p1H82iUK
         dDNgWzrtI4AOBsdo+icMKbusJFIaI5GQ4aPn7AMAX/47s2xjBnRMwxeVrVwrvmpvcU7a
         2Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729636822; x=1730241622;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ogz5IrclLTw1aKz0Jr4sQzXNdx/+9D4zH2hrfc475g=;
        b=kHe/zwOuc1KF+3YqHbtynXVT2pHwfxFEDi04EjVEZU+CsmXZmaupD8w1sbv+DZhAiF
         5W/7D6vs9zEZY0J9xPxmOZgiLnW3sktVmZj8jfS/q7w8HwnGfHMERj2w3bwKShvHPtI9
         lr6QJKIwzmsXDp6nz5nOJZAsG48GygUJ2mgE/zc8xpVzLdDAM8T0bK5ObitEVPfqUt66
         9tJeF1/+8SWQ9fzhut/9GE26nbOq9jeSgzx0bKjImm3+73y/c0Madh3lRv1QjVhq9B9f
         Tgwzj3j93lptKiyL0cdnnZFS2YP1dwC0fBPanFQE1ascvVSjlxi0yKkFd0m3l5uah5MF
         rU4A==
X-Gm-Message-State: AOJu0YxzTIPURpWm7HY9xLJLSpjehBKVn98I1E3KlwpAAv7XtCds1yI7
	34mQ46FDET2tqECOpDzGFZoC2Ziuwcdzy/7Tspmgb0kTiT7/TbCMxzJrDRXqdfmR8ZycxPy06ht
	qLMpk9Qb7dGrBebGQcdcOtE0NnuhqsUqCIaoM
X-Google-Smtp-Source: AGHT+IEmrsL2mmkfIDitJhu5hcsn1FCdFgoNp9yTZPRQ4wh8Fc5z5cgTKRA2GP4UtQ1w7pzOVlBNjul4y6nKwKhEXes=
X-Received: by 2002:a05:6902:1246:b0:e29:2ab7:6c03 with SMTP id
 3f1490d57ef6-e2e3a65e7a0mr461330276.33.1729636821968; Tue, 22 Oct 2024
 15:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 18:40:11 -0400
Message-ID: <CAHC9VhT5P_FgPr=k6y91HjTMM1GCQH_kcPR=p2Ux-coTYYR_EA@mail.gmail.com>
Subject: Commit 6e90b675cf94 ("MAINTAINERS: Remove some entries due to various
 compliance requirements.")
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If we as a community are going to drop subsystems/individuals from
MAINTAINERS due to "compliance requirements", can we at least
explicitly list those requirements in the commit description?  In
addition, if we're going to provide a path back for those who have
been dropped, can we either provide the instructions, or a link, in
the commit description?

-- 
paul-moore.com

