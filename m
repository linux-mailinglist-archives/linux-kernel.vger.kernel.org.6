Return-Path: <linux-kernel+bounces-413596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31F9D1B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D82D281CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F641EABA0;
	Mon, 18 Nov 2024 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="hdK29ZDk"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9A1E7658
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970890; cv=none; b=hrBnpmBvATwE40dck6qXw1LgswJ5c02sxS8Iz4yQ8sTEw6t2SPMNYz8tu6AuoXli0fCD9iMljCZPWodHcM1XWVRkZN6kU90WgIJ4GkSVq7dLkTbcWN8i0T0T2+5dvkFag8qxW2BVXm/Ck013LRo3IoFW24gYO/svjjOFEonytqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970890; c=relaxed/simple;
	bh=Ee5PxbIPGEY3vOYIWLNMw8IWhhbpyXqzrak7Is/R4xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XgFaUmgfL+DEdbLLU9YfMaX6+xy9AptCn5Y6iXUdn+GF14NGdc9k/Y7ja1PzQtlFgi44I70eKLVE3fjz+0SNL7865B+EOvL/GthBbRranhNjW6urAKQu9kn5wXq4XwQoenWgVJKhQSTnpQXkadTJUMISXIlFC2WfdMLZFYfytos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=hdK29ZDk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1457ba751so13898385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1731970887; x=1732575687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djuvR/hK6Phqs0gApr6Ryi9KOHrK/yeBmxBlrxcxSDU=;
        b=hdK29ZDkpAROi9RSRi066JV6r6LPEjMSFlOBr3CzzKu2LMjKPVmQL7gh/1pE+WYnD9
         HoLfphtWtcrbzRA4+H30S6rdLEXvtTJUhTX9sx2vs8skLAFQX3vFLNELro8/gUwwhYVx
         8BwSU3uNSCN7DqAuZrAyvpKoXQCOajqf5kqeZO1sGWR9ywe/hk6Y0StFy865QLeYrAIr
         KxklsP8Hz5JJ6qfBcqad7lWXouVrip7F4siVwlrED+rBtUyEcJGOvebaMbrpilHV9fdt
         Q2oHvyswCUIINPpNmSD7m6GSBqaY2Dm+4V0K8uIoPeKYB55/QYR/OmaqsJD+sMFX1kJs
         1U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970887; x=1732575687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djuvR/hK6Phqs0gApr6Ryi9KOHrK/yeBmxBlrxcxSDU=;
        b=FvxCGdwJh5xqlwldqJEqigS84gIULu9tw2Uxkg+LusMVmVxbGVYGzJWRF6OQ69Bxuu
         /iMyeoKttd9PRNKyLiGhRdmC2vbpJel75DeQPiXjH/M6jM4NG21KlnaKuNaAS2I5cFST
         iNf+9L1PCH0UfE2XWnA7PHwOBghKwCZ7WrbOzAyPdHdexn0YOIGNtfvBi6rG7oIBd4iQ
         HkSiZTDcFrc6iDkzdgY83epLALCPW4VHOKI2ZEwArY9fbyUCcnMCX+eBfV7Ec6GhmPw5
         8Lq6yGh5UT9kvm1LG/yRoJxhPm5R3r5te9YfHdv4Wrin/C77jn8Tr9EfJGwDO2keKV4Z
         iRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGiqZXym1LwBL0tOfeTH3duyunBmB+Witev0IXbm+o2h5FLjRNS+zgjFK4/uPQOBGE/JUqwT/rmiMlC8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeYGi/B5ljP6dVF0gbcUwdEQNJdiY2Hts7yndPekB7KjoqJ1i
	EZW0aFqqFq5Qvqu8lF/HGsl8MjGCQBKQuLa7nUzoNekSFC0Gi+2jYeT7maM0kQ==
X-Google-Smtp-Source: AGHT+IEb5VGhHOeSAKca+M48dLT2SblGVszeSfsokiKrXZGx+fD2vDeKB6QVtLklhRn01Q/fEOq68A==
X-Received: by 2002:a05:620a:45a4:b0:7b1:4d6a:b99f with SMTP id af79cd13be357-7b3622aadbdmr2257319685a.14.1731970887347;
        Mon, 18 Nov 2024 15:01:27 -0800 (PST)
Received: from aus-ird.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a897eebsm35344185a.94.2024.11.18.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 15:01:26 -0800 (PST)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] riscv: uaccess: optimizations
Date: Mon, 18 Nov 2024 23:01:08 +0000
Message-Id: <20241118230112.2872978-1-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Orignally sent by Jisheng Zhang <jszhang@kernel.org>

This series tries to optimize riscv uaccess in the following way:

patch1 implement the user_access_begin and families, I.E the unsafe
accessors. when a function like strncpy_from_user() is called,
the userspace access protection is disabled and enabled for every
word read. After patch1, the protection is disabled at the beginning
of the copy and enabled at the end.

patch2 is a simple clean up

patch3 uses 'asm goto' for put_user()
patch4 uses 'asm goto output' for get_user()

Both patch3 and patch4 are based on the fact -- 'asm goto' and
'asm goto output'generates noticeably better code since we don't need
to test the error etc, the exception just jumps to the error handling
directly.

V2:
I've taken on this series as there isn't any response from Jisheng. No
significant changes other than build fixes.
- Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
- Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
  macro.
I did read the discussion this series generated. It isn't clear to me
which direction to take the patches, if any.


