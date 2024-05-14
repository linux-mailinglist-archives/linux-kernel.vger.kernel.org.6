Return-Path: <linux-kernel+bounces-178235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6E8C4ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1433F28353A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4B17FF;
	Tue, 14 May 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dklfrgzc"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB151370
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649910; cv=none; b=l34/+y7IKS0nyDMsfk6kYMaULnSALqdQkT4AWj7cglorHxy3STj8OTeggGRvxQ5llBei9TBOuTeknbP+qemN3DgB0tlM2vSYHKUDQXmSrKpCKlaeNwRFq9RNZarcMAtMt6tdvfHkI3oSOb9ngsiebyWhQKTf1l9ItFPyPJaGioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649910; c=relaxed/simple;
	bh=/TH96uqRSeZ811mRj236VwS4reF0/8IJqNfI7Nli2Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvapWUe0g1MPbMlF5VVxhy206NE7/ycr9TKBHIom8UiJ1jFkqfP2YmdkvE6BG3+rxz2FpIvWTFx+kIGncdhcDLedgZsYuEznBke70aWW3GpUgnXWWNEpRiAz2gzCNoF5/KAWrfytCgdaaI7xE8EgVSZnfaetzyRsfEC4Pitj9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dklfrgzc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b37731c118so3945683a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715649908; x=1716254708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TH96uqRSeZ811mRj236VwS4reF0/8IJqNfI7Nli2Z4=;
        b=DklfrgzcAqsspPkTBDJgHNy3lyVSWbeYTLCD6DxonZ/qsRyYQDLDwnKu68yh0/Jchw
         +nr+2IaC0Pi9eblafqnLpRjgujnJTDXxXQAH9zZT0MjPG8xAgGUh8AXAJ5rPbTK5vLu1
         jBDrfne7n/MXjvKs7pLKVHmsCzc6ujkxxGn4iO/bGt60GEkcUJCyb4w5npeGlYfmDm8J
         UinQ/ICm4QU0Ny2nZL3l+pzmV+hWZOju+k/4+J5xTdp+xSOkJJA3d8g5Zs+MXtThn/KR
         PcAZUN9L1Ndg5UfGys9mXgECJLjMxEUQMOOtxEFd3Gui3cbH6BnEsQjXlpYDSmy2J+9w
         vJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715649908; x=1716254708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TH96uqRSeZ811mRj236VwS4reF0/8IJqNfI7Nli2Z4=;
        b=xJm+Dazzlc1JaoO5PbYlNK8JNInVZ3jjDAoSqBzsswDjaMYWqHKE41rFN9gVGWD5vj
         weLxvrn3MRgVRZP3gKkf4ETyKoJijUKt07K8zQQqDIXEK3eRFnrEYVsp6LBgpSwFVQki
         s+ATBdYfAhvQHYFjLWI3RRhJY53FxV8NHOoKlOOfoixFK+ZBB1zBP0bO1pjr6WfQ8wl8
         4cPqL/31hXMf/E/34diAnoWk26xrzZGS0aJrvF3GM3x2AMwl7YszTYjTq+cKqjLez9/w
         apNhFiDbD2tRpOnQjCNb8ReBGI0EspHDNH/812vlA18VG8g3WxnC0KIdyz1hHTNu+W2X
         Itvw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJ1n2CZcSwyM4QVqXGVGoJEo4KpzbupkzMHi7vfAKUaGupNnCWdH9AsQY8dJD0E+zYuR2mb1KukVl8B0fQpFFCXVhP6RW/+iDb19p
X-Gm-Message-State: AOJu0YysO+bPPAbQfEKzX5rb80JFMEi0B7iZmo4d9gCujEjBzux8PWGH
	PJDr8k4tWFM8R2molEbD52yXYgsSKUOZBvnjTmOiBGz0LxRf7UnV
X-Google-Smtp-Source: AGHT+IHore/ea72KLeoFLsJaXtU34ZpCKTZThWUZgXUE0tk+V6NMkj40oX+s5If+4LtYQQQlXFM2lw==
X-Received: by 2002:a17:90a:f2d2:b0:2b2:9359:ae3d with SMTP id 98e67ed59e1d1-2b6ccef6b0emr8026524a91.49.1715649908171;
        Mon, 13 May 2024 18:25:08 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53cesm10394328a91.44.2024.05.13.18.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:25:07 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: dennis@kernel.org
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] percpu: simplify the logic of pcpu_alloc_first_chunk()
Date: Tue, 14 May 2024 09:25:00 +0800
Message-ID: <20240514012500.248851-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZiiUoC5NokdpvDgN@snowbird>
References: <ZiiUoC5NokdpvDgN@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dennis,

Can this v2 version of the patch be merged? Or what else do I need to do?

Thanks,
Yuntao

