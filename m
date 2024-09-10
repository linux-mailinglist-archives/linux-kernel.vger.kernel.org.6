Return-Path: <linux-kernel+bounces-322501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F99729C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0F02853A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C773174EDB;
	Tue, 10 Sep 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFfBLal4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6017149C61
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950793; cv=none; b=KgVuZdeWzuYvHTnUrOGoMrUb4NuRRZ68uUn1u73YZWBusbBVF5AX2UeGKSw/sf1L/3dOAucyOloIFcEFYXJG+pujhUn5qsAWmLEjRTHGoCJc2buL2jdPyuE0qhwBKKCuacbLGGf1O+E7bGsxlqFCDHpL62vTc5gMENunwvk3x+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950793; c=relaxed/simple;
	bh=IgJtQhlVNNB6gks90AptTLEm1gUnqiD6wIC9RivdacA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LXyn5RP5VG3fWHyGspZQbbOUgKMgaC85+Brrx7ADAQtUizn1qf5FjgZMikTb31WzgMIwCntPXiTgBqaDx7w0TCDCh6WvX055q3tF+pqNWxbAyGuLTBVumF3cJRDC4lwjV8DIw7UYxUivRNKH/E6lwW0W2MMXDDBaH9XmgNKel1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFfBLal4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725950789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BDGIrkWXCfGdLkFrf+H1vScUhitzw/gRoY999JXsR0c=;
	b=UFfBLal467UFxRyYekYka+MogMuXo/qXAEiJ7a9rswcFTgbPDAtuel5D/M4QJU0Eb4BsA+
	kcXZaAyWIBDkdbskCQbW8a/4CHr3g1dLU/PN067p7crDiR8wVfv2xSvWp1uy+BnAsfRy7Z
	+r4ek9Enz04XmQ+HMxLupkdV4ZVM5o4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jyIQhPDSMz-PU2AkCkaeQg-1; Tue, 10 Sep 2024 02:46:27 -0400
X-MC-Unique: jyIQhPDSMz-PU2AkCkaeQg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb33e6299so15187305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725950786; x=1726555586;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDGIrkWXCfGdLkFrf+H1vScUhitzw/gRoY999JXsR0c=;
        b=G9u6t4AsQc0/CorfvcSK0hOyey/JRU4GO7TlOjgvFkN5fjKgF6QyWVNWdfHKOMX/3J
         QrWglUEuwz8b6rTj7Lfy6iyX+n8jKwrYxND51jeclOq1+7gjyqm+WUFwKJ6HjUKfPMdi
         0gQCtyFW472X2OX+cdznAp4/KtHAgYu2iwKss2bST8Kyk1sEJoGEkfJE7MIIU97kyoXk
         DeFsN55SG1resc7hfW1cZ2Q0TDxklo3ZQZGym0z/8di05NJHY8a6wX7HCa86mJKNA2W1
         TJEy19xcL8v0CJ6faenbWzlMeS9x/mNyqxhQQZEhH8wmL1Ge2kNHfqMx08aNEHZJzIuM
         lDlg==
X-Gm-Message-State: AOJu0YwxvbkbAxrVutHyNSOTLQ4fs+O01xuaViu3Z9rKIqesQ02yEumv
	aU+aQKsoJTcHUh2IhlGakUWmphHv4HbWl/QF6j6eEBaMG9sx16AMQYzHLyIoe2EmsrL8N1BCwUd
	fW6/birEXmFXSezTKgzEbslgJ0xUFOfRZnl0hvQUNf51tbdZYuxx++Be9K3J2PuNr84eYmJNNbi
	vq60DI3WziInhro8aqEY78geg9VF2kFYiq16ff5gI=
X-Received: by 2002:a05:600c:3b04:b0:42c:b7e2:3bc3 with SMTP id 5b1f17b1804b1-42cb7e23e55mr36386835e9.19.1725950786058;
        Mon, 09 Sep 2024 23:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtkHSZTbUpMNFHTKXzd0pHvsO00hKpglmCaBMMNAT0FG5tpGi/KuHVOyFwcw+4u+WtBVXH6Q==
X-Received: by 2002:a05:600c:3b04:b0:42c:b7e2:3bc3 with SMTP id 5b1f17b1804b1-42cb7e23e55mr36386445e9.19.1725950785343;
        Mon, 09 Sep 2024 23:46:25 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm8055905e9.1.2024.09.09.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:46:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 02:46:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: warning: objtool: data relocation to !ENDBR
Message-ID: <20240910024409-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi objtool maintainers,
I noticed that each time I build my kernel, I am getting this:

vmlinux.o: warning: objtool: .export_symbol+0x3af10: data relocation to !ENDBR: stpcpy+0x0

Things seem to mostly work for me, so maybe it's benign,
but presumably the warning was put there for some good reason?
Am I doing something wrong?


Thanks,

-- 
MST


