Return-Path: <linux-kernel+bounces-341403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF6987F99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89256282C40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA418787B;
	Fri, 27 Sep 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmQb5/xE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054C17BB33
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422905; cv=none; b=f5FVTcZCEh7TRzSLcgX78pjCrxYtkllv4V9I1g074XaWhLxvOx3n1Q79umst9T5lMNgar7kpO8KoxcKEmOhCij8zKZRNuox6X6XhPjnIQcS55nOFI7JJIfzrv+UerG0K1JUlN4rUM0yhSTAgkmD0fIukAHZ2oy3b0G7Irv8bXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422905; c=relaxed/simple;
	bh=Nq/GzUihNbVYzxTa7EPEL5sIN9ljkiIkLuozmHVPcAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XEm/bQ1XUAi8EWAMrblSj1DAXUsgfSNZLWa6MogEqc/xQZduRBVEOg9iOqQ31V9KNrdB4JE4Q8vxYYrloyo7NQDgJ2axjlMYT9Ygd5DjHBc8PmTuM17jvcpF/GOWrkU9V6j3QblXsb5cFoRrhcWqHaq8iuiTU+EJoMmOGppPWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmQb5/xE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so35265147b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727422903; x=1728027703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX65nEvrl8c2bAG4dwYO3ALnsJ3H00hLsCIdrQbSMT8=;
        b=CmQb5/xE/Mfq1tt8P5H647Tpf22z/giXmVevXn/Zs4jXh7W4cy8xSG2oLidm0Tb0rn
         2uI9lskr4ukmEQBmS+yGBB+PZWciI6b7o9kA706ajhqGuzzHMBGSGRO19ZY5KN8+IKjq
         4ck6LH8v2a2ziSG/nh5bx5gGtzICwAhAm+Wadcfgs7HhzY3lCpmKUOMVlo2yZaEMsc6C
         zhA33eFWhnYgsYoJ0aug2acJvljep94/VOLpin357D7mAMA7B+NTnct4AbyHdfLBgsJP
         o6+mrnTQbWzURIPAx4O6wlw5C61bMYuoXPyLDGt6hKLA4f3DVa9HoCjphDDIrtr9PF+N
         t86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422903; x=1728027703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX65nEvrl8c2bAG4dwYO3ALnsJ3H00hLsCIdrQbSMT8=;
        b=BNYZOYDF0ZePOO5bGP+OS3OGXm0Ems+2g0PXN0MV60e7TDeGuJnlcSiu+iRWMPkHKk
         ALcI1yyLllYTeSNK2bm8uf++8GCxHNDHBKn/gPF7NbM600aJn7KPrilD20mpNtuquCB1
         LLB63lflMtKQ6qbmNXEXrsAriYRs7BE5cUu5F8BfgF3SgapmfD8TH1SGHcA+HXNMweUm
         Ekm2a+5X7Pr9RJY4NuiwvjR8m7pLbPjL6T1QEl0X9CZZQg2zhaST1auziKK4V0O07A+x
         z7motuL+7tTVtGpjBVZmT9ciU3CjTyn077Imw8oVmuzYWLWor90yKsNjvU949rr8tSr/
         0EqA==
X-Forwarded-Encrypted: i=1; AJvYcCVR3vWUhAsSd1wPhTuX1EIFy9s6u4GOuZn0Zc92SJ79IDfEs6100bXTlehST+65e583mxTL0VXwmEE2nQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/bDJvBDSZkg0JcoY/3cPEoXFnt3nRRS+G5YWVq3tqmhFYP1n
	4dFEEry4P2SnUQR1KmFfbKJ2rD3rS+/jqWN3PMmu+8nnTDBnpk9KGyeNGt91lYPWLMcrCcnn1g=
	=
X-Google-Smtp-Source: AGHT+IHv+V7TrnoRkTknrxCQf2udj+QD2JXSuqMR8tmU8ZFo0gB5BIQ6MEHE/Kyko7jUwDjudbLD/oXTFQ==
X-Received: from liuweina.c.googlers.com ([fda3:e722:ac3:cc00:99:2717:ac13:e22f])
 (user=wnliu job=sendgmr) by 2002:a05:690c:700d:b0:6db:c3b8:c4ce with SMTP id
 00721157ae682-6e24762237cmr646337b3.7.1727422902920; Fri, 27 Sep 2024
 00:41:42 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:41:41 +0000
In-Reply-To: <8e02ed1a-42a9-41ab-b1b4-cb5e66bf4018@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8e02ed1a-42a9-41ab-b1b4-cb5e66bf4018@linux.microsoft.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927074141.71195-1-wnliu@google.com>
Subject: Re: ARM64 Livepatch based on SFrame
From: Weinan Liu <wnliu@google.com>
To: kumarpraveen@linux.microsoft.com
Cc: broonie@kernel.org, catalin.marinas@arm.com, chenzhongjin@huawei.com, 
	jamorris@linux.microsoft.com, jpoimboe@redhat.com, kpraveen.lkml@gmail.com, 
	kumarpraveen@microsoft.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	madvenka@linux.microsoft.com, mark.rutland@arm.com, nobuta.keiya@fujitsu.com, 
	peterz@infradead.org, sjitindarsingh@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

We from Google are working on implementing SFrame unwinder for the Linux kernel, 
And we will be happy to collaborate with others for adding arm64 livepatch support

Weinan

