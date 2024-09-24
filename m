Return-Path: <linux-kernel+bounces-337149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2B9845F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD03E1F2393B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89381A7271;
	Tue, 24 Sep 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIVOMcIZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597C1A4F36
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181145; cv=none; b=E8it+2NGYVtoVwyilGf88/Jp2SFw7NBotwUuwyoQvkRU3uJglhaWXbfM53jPxWMuZ5dUtXoy8Bnlo6cA3VBlBlxm9EcaCrdkMD36sAOUNqdo37BCtfskZOY3yvaLL3WwxANgVvPU9A+vyXxbI5UuPWtirav5MuflO/Yggc+6Flk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181145; c=relaxed/simple;
	bh=fa4wbI2H7BQpFjDEj0tUmJ4C3pt3WcWG8N4ektT8G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q3ACfuuY0pH4rEOD9vM3rHi5WHpjT2VmJ+P7WrAV3WBo6aSfkJWnCF1NC81VQxjSTX+fOoAjf11Uv9zJ0USO5Craqb08O3dHTsl7tbereYrJNqWQTin1ZoSmTY4M3BRVDgtvV4aUBua3nNn3x5lAe0Q8TlLlAtkLM00p0nhhD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIVOMcIZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d704704aso4802288b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181143; x=1727785943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fa4wbI2H7BQpFjDEj0tUmJ4C3pt3WcWG8N4ektT8G6c=;
        b=cIVOMcIZqc0r3NfAqJ1oX+n4/cCSp7pLE8TM8jy5QJ8ZeGSQd/1RZyH998QaYNrk+r
         40gQ+2U04lqbXpa8G5RIHW3AxamLTHTaXK+AUosnZE0fxEP02NLiRBpzTwbVpZ7JYAiF
         RZvcouewgEFR3x3hukMJ7sz6nxpw125JQcgkcMOiAPIX70F7pgdmgq8DEr6LQarPYYIo
         Jr7geejphlF2KkWv/asOV6gpvHjcU5nHjwO/ZETljgF2IB7+zZxRhP4YVSCxW02R8xWI
         ZQ2sAExJ3uSP2gSrEpan2/vclvwWb0YkEwQpYk8RLyOTVi0bOgieZ0Y5Wgo+VG+d5DC2
         mgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181143; x=1727785943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fa4wbI2H7BQpFjDEj0tUmJ4C3pt3WcWG8N4ektT8G6c=;
        b=shDfii/RvKipBn85bbOwXe7XgB6HHDxKYIAOjXzq9/m10e+JLZDS+ySzFVVOkf4F8o
         1qB77xdi1qFZHcgJ3SXeL3y9lLEI8c0btO8zO5a6dnThNBbha9QysrgnaxTUTtxFUxoV
         sj3UyvZ4wxcS7nfgswO9iBtslwWw41wqPwRL4jNBtrAGJQixruC+Np6pRn7ITUC3i91U
         JJhCTk8HTnKOnZIGJlGTx5gOA2gg6vydzZ9uvfIfvoddpnCrID+hjXBiKaYFJxag6XQh
         ePv+mp0GWQpMaaG5RskDucmD0wohsQ5Ju9zdcT5pVGdm91YMaByqV3IhcYFKObKG5K9o
         fhmA==
X-Forwarded-Encrypted: i=1; AJvYcCWqeyFJ30iCeDl2wdjQZomR+bBW0uDjn9eZYLJexUOKKVz/hWxB2U1fdNVDvbrBjTCKwQaVILlHDmN2708=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWVOn/gJBcqsUi/x+JQbxnsnspV8nnpeT6U6jZi7WUFD1BwQr
	R1D05g7VjbSLCDLk5JAuCDvFaj+1PSyR8pdtvo8LU7TWptbhFqNz
X-Google-Smtp-Source: AGHT+IHw3N6vDPYprm2wiJIo/e9mKA5Qn94lM4BTKR1/Av6asUWjk/ekamG/qpVxAy/02pBqCgh+wA==
X-Received: by 2002:a05:6a00:b54:b0:718:d942:3475 with SMTP id d2e1a72fcca58-7199c94f94cmr18055937b3a.7.1727181143033;
        Tue, 24 Sep 2024 05:32:23 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:22 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon library
Date: Tue, 24 Sep 2024 20:31:36 +0800
Message-Id: <20240924123141.16962-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I have made several bug fixes and improvements to reed-solomon library.

There seems to be no maintainers for reed-solomon library, so I have to send this patch series directly to Linus Torvalds.

p.s. Revival of https://lore.kernel.org/all/20220806162510.157196-1-zhangboyang.id@gmail.com/

Best Regards,
Zhang Boyang



