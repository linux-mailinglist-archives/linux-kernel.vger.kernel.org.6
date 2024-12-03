Return-Path: <linux-kernel+bounces-430222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570A9E2E04
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE56162F8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753B207A20;
	Tue,  3 Dec 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-hamburg.de header.i=@uni-hamburg.de header.b="kQAV5zg1"
Received: from mxchg04.rrz.uni-hamburg.de (mxchg04.rrz.uni-hamburg.de [134.100.38.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44A1F75AB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.100.38.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260986; cv=none; b=GYtD4Zz13rT9N476OQ3xcWqfNDOvO+q+kkUu0F3HPQGxOlnpQU4CpW17GEvR6t6ihh8/Vfqdb40YP4c8yVWdb1DlyFEGmg6MDMANqmLb22k62C27my4szj0/gu9KqkWqfvZUtggaJlH8xtb8pHS3VLYNeMzg1qHl612ZVNpKoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260986; c=relaxed/simple;
	bh=7ImcT9X6OeasvmYOtfTUAGvmj/4277VgcxWggrlwpbc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlyOW9ZRtvtNXz73mF/lJ4Ff6FaoetMHvr3rAuQzoanlbHHycGTBDTzZRKWTSvoW6NNqoKXaQIcrqzmUrRtDnvn1GxHRBM7Wna9QEsqoHJj8kvI2b2usY5fAvtAeaX7++kdun37KkTU4t2iIKDxz31OChNZ3r1Ugti1ZV6CAD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uni-hamburg.de; spf=pass smtp.mailfrom=uni-hamburg.de; dkim=pass (2048-bit key) header.d=uni-hamburg.de header.i=@uni-hamburg.de header.b=kQAV5zg1; arc=none smtp.client-ip=134.100.38.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uni-hamburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-hamburg.de
Received: from mxchg04.rrz.uni-hamburg.de (mxchg04.rrz.uni-hamburg.de [134.100.38.114])
	by mxchg04.rrz.uni-hamburg.de (Postfix) with ESMTPS id 4Y2tkp02qbzLldX;
	Tue,  3 Dec 2024 22:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uni-hamburg.de;
	s=rrzs003; t=1733260610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ImcT9X6OeasvmYOtfTUAGvmj/4277VgcxWggrlwpbc=;
	b=kQAV5zg1/NCp7CxOHTJwBzZ3A7spPE97XDZbKl1FDesY76oKIb8NVc3XszKJFX6VcPnudY
	AA74xB17eRgri5Je5osXFe78mWGtNI+7nXv8xT5GFBhum+sPpV6rtss2ayoUQjn7DLu8mz
	PboYYmCTC/KGFDcf5HffyC5MIqkmdSyBPMxBuQt7TFfsCRJP59Fi56QT1GPT6MPdzMHluK
	JiQIUDa/ur1jmGh1uX+d7Te4BYkUSP05SvwH0RdLwgKIW7iQOgUm3nuMiwaI6J02ZT3Lwr
	F7PGrAck3+adAmsSPvzLVrOVdhyhD8XrB2Jd2tBTjMitqmOOlRlyihjeOiXiLQ==
Received: from exchange.uni-hamburg.de (EX-S-MR06.uni-hamburg.de [134.100.84.89])
	by mxchg04.rrz.uni-hamburg.de (Postfix) with ESMTPS id 4Y2tkn5KKBzLldW;
	Tue,  3 Dec 2024 22:16:49 +0100 (CET)
Received: from plasteblaster (134.100.32.91) by EX-S-MR06.uni-hamburg.de
 (134.100.84.89) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Dec
 2024 22:16:49 +0100
Date: Tue, 3 Dec 2024 22:16:47 +0100
From: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<ismael@iodev.co.uk>
Subject: Re: [PATCH v2] tools/accounting/procacct: Fix minor errors
Message-ID: <20241203221647.5892b37b@plasteblaster>
In-Reply-To: <20241203020550.3145-1-zhangjiao2@cmss.chinamobile.com>
References: <20241203020550.3145-1-zhangjiao2@cmss.chinamobile.com>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-debian-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: EX-S-MR05.uni-hamburg.de (134.100.84.88) To
 EX-S-MR06.uni-hamburg.de (134.100.84.89)
X-Rspamd-UID: 586a95
X-Rspamd-UID: 4d4d42


> Reviewed-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>

I repeat. Thanks for picking it up.


Alrighty then,

Thomas

--=20
Dr. Thomas Orgis
HPC @ Universit=C3=A4t Hamburg

