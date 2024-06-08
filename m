Return-Path: <linux-kernel+bounces-206934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12B901005
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77D7282A89
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEC140389;
	Sat,  8 Jun 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb9d4HoU"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3AED9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717832448; cv=none; b=WIzYpeeFZ2//s+lcGglc16z1CKIk20eLNeLFrpeJIRdqLELoUAnzHMVwNQ3EqyJVAbXgjyTHfJy9tlAxiCng099b63q9nyvOXDs52pLARmNqlyP8x2J0S1ykqx1KpOkewhtTuSJKS0JBy9Yonl7/dVjF7d+SuNtRIEuW4UDeXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717832448; c=relaxed/simple;
	bh=AxpNIteblEn/4GY1XvkEPZKmkuXDFGG9n8qrJc0vbTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=opSDqVs53gs25cX1Xx0O6YgA/UDSdv/N+tO588sJGPUMFFCPBP32udYqj+4Fa69Gz+XLViXeeQEeZ0Hb80dfnoaTdsJo9di0UPqZpE2+nNJsnQCvIYo2oSySf/K42ygPku9ZMcGjqR1+RtH7Ab/WL7BCjlx8UzZU3tbD5Y+8fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb9d4HoU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso165645666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717832444; x=1718437244; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+ui9jC/Xinch2NwVNkta+FJYdj2bjXrQc1vpDtK0Dp4=;
        b=Lb9d4HoU6Yj3miDaDecKIS07/0CYTjwAToNKrvEwRV0ZkDD/taBzUKyAA6kc7ObuWo
         M0t/GB94/0uZcs2R8Z3jnLCqeMdsx2EqScQm+Zrx/5elhyGOE3Ywa0PWVox7P0DkRBeE
         9QMBoqBDTdnZWQqT3Dv0k/PKM1Aud6VvNsMNA5nFKBgsmntWITODBFZ4xJwla3FLZUhG
         pvBsFhp7F+oKAHVdTNES0/cVL612DFaHRF60yjP50C4cAAe/Zww8hiG7VtF54rMtD1Vz
         g/zESH8klWx407BCp5q8C8g0q1Udq4zfTC2FGP7BBEW8/ScqgoyD9a7x0m29X3cfAeIn
         mvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717832444; x=1718437244;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ui9jC/Xinch2NwVNkta+FJYdj2bjXrQc1vpDtK0Dp4=;
        b=wZP7qI9P/5aV/HsxoLmCNE/Ju0iiYDffvbOrKRv5nXPyIjLe0TjdO1brxWrtafG17F
         E6AIHw75HCo7CA82q0g4eb9vTs+t5toF78juxqTNk/PLoyKJ2q5xrj1yOJU/bCMonTlM
         rM5m/lR8OBJFl3jy5qwyXjPzR8HmbKDaACTSrlon1C6Hn5WnyX2VKvhjIaHLylVfTNIP
         Nk9/h3OToQXLbO5ppVhiUcktiKYo0yTnVRBESSTI32r6NnUAKh2FTeHTdgIbrBJFIhb+
         EHH6CoLPlAvcZ1pyKTJ985Pl/sbQxTffUK6TkIwzSOf+yA/rIMtiClACOJuQm92+Ffmx
         KB8g==
X-Gm-Message-State: AOJu0YzCt37g3xiN98OWBbJHBP2S5ENmvj37HCLVY8Q9RZGSWxqE8jEQ
	q5F+JvmMhu3TkTD3B/cOG/BwfvO40TEtwa/48CGEViOHV4xHT/qY
X-Google-Smtp-Source: AGHT+IFgU+l5q4AZUZvFlJ0CkqjT70q4rEImXFLe/gEtjNW16nUVubfrxE8tOPC4XLn2GR40jCI2MQ==
X-Received: by 2002:a17:907:9694:b0:a68:ab53:50e7 with SMTP id a640c23a62f3a-a6cdbd0e372mr360030466b.69.1717832444081;
        Sat, 08 Jun 2024 00:40:44 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f073632ecsm35758866b.108.2024.06.08.00.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:40:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Jun 2024 09:40:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZmQK-WsCPwR_DB0n@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-08

   # HEAD: 74751ef5c1912ebd3e65c3b65f45587e05ce5d36 perf/core: Fix missing wakeup when waiting for context reference

Fix race between perf_event_free_task() and perf_event_release_kernel()
that can result in missed wakeups and hung tasks.

 Thanks,

	Ingo

------------------>
Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference


 kernel/events/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

