Return-Path: <linux-kernel+bounces-518274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD4A38CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C69166A84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49224232378;
	Mon, 17 Feb 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VegPp5T9"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352322B8BC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821861; cv=none; b=bD+ntrNWdGoD77S8M+x/dwROhlSPS5n572zRKH2m2mzw7S1MX5irQ56Qey/QTPORia8XEBVnjj7g6jJyygX57OE8qHUCwFLk8X2ZlFSeSOcnsZQZjMiaRnEhcLZ14Xjy6OhARIr7CCYn7M+ZHQidIlPBJrTDWooAYL0YOcYNmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821861; c=relaxed/simple;
	bh=8djotlyOow3U6WpdapdKdiyo3bMweGbclUeA8Uvft7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcvxARcT4vrgPazNQxwhn3vffJ6eNyeMwJudqEOGejgmW883Kv+ZfIQXpeOlUe8X2rIfXs2IwN5D+7k6QLqrZk7uBcVi5skZoPIVyGcNYhS4La8/xXrI4YtAUYm6duIfBCbJaEWZuNg6TTMLCpwmHsxhlwTSrE0jhaqYOqu8ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VegPp5T9; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22104c4de96so36109415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739821860; x=1740426660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MqTA0vRxn2Uf7ysEV4axwxSXNlJYZ63FyMvrvWVGdU=;
        b=VegPp5T92mntyc01toXmxEtM1WuWnVIWMTAc5LPyssqkWxBIchJEljktTEsu4ZTDsK
         UQWwIHbfCrA3ecgNCN6Mk+vf6GFeNX5dYOu3VZVwjUpJslKwY2u++xDkbQ4ioocWlYk8
         pJd5fYN8M4ZJZnj/vW2DaQ1bqT1oYPH6ajBup6riiSPOOOkckdUCu27Hqt+JuHfUB+Rd
         bBGS1s9X7/PrS2hzckX04Je5+OmKnbZAyzUXZqPrUNv6gBgaIOpdCnmbhifz3qg/WyLA
         TFBL4QaMAyOC8xDG0CqrqZZFS42lDFOlgcoS1dal7LwTORMox4l7vNMjHdZBHNMCDFkp
         h2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821860; x=1740426660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MqTA0vRxn2Uf7ysEV4axwxSXNlJYZ63FyMvrvWVGdU=;
        b=P7/reC9i3zQVCZpXpXKqOYtGGU9y5w7oEHB/eNK9LUo1fILuuHi0gC0jSX+OJlGEg2
         DOMzWSlvy78zJa8X7yAdzEzApFvIBa4qw432UWlBKsEfxcGQs9IDse/L7O1qcRKXDz+S
         7zZERxylRSmQAxEgaI5ADrpxuNJsEsvL5Vqj3O9pLbRXRWmCNL0UL4v/MVYfUlhjcxpz
         /COXBi+fc/wvujsQQv/wMFhRI27Rl5tu/KbViQS0bqjjpZUEQpeyEj8gAxvQ1ZddR4GB
         FdCH6eQEc760OjBYTFKt2i/TUJ00wAOu5L3kt+cW0ofqwGNRbI0o23RWxQP5sKcUdZ/M
         GjNA==
X-Forwarded-Encrypted: i=1; AJvYcCXtg4FShJSvZHrY/Gd1J9B1ld/p/J9NUGMUslrrcYnSJnMWIeZy6ua0Ef/gkMyne+ZuOYp9UPWt8hEeijE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcL9wIi/dVYHjRJlfd6bKKpPbt7UHWo0iqGFpNuldKXNKqpJz
	CFvgcHnpJv/IR783i2LQu6tz1ILb+boufC6xLzII8wn2kM8reSpIiP7z0dVfNuI=
X-Gm-Gg: ASbGnctLnYL48n7wac3yPkMVom5xl7Monk2NUdldZcnu7HUH6R82B2vBQwyjXXl3mcy
	JriJalhCmlsVUyeCvX4HJ51VO0jfc71+a/Lxcg8SFQYBvtxZXK1h9l6K49hZWpMBn8aF+AY47O6
	3YjztTLt5NMX23jyy0jGcB8xzTdHmzNwpHyhps4ltL5FUSSX9phbss0eHnp4+e99E/hYeeOd94c
	Oy1J1HAAoJeNcwG6WNcyCkRU182FtYgtTR9gCK3Uu7V0dm+slkQA44SXpuXqba/iIOj6C6/rPph
	KNfUJTdIxx+3VqjzpT3I
X-Google-Smtp-Source: AGHT+IFQqlyGGnwP1AKUpdQjn6VhX+4WnkPIk9II4OV70FotBJjNMX3/QzGFqNNsrzKLYgtOZkRjGg==
X-Received: by 2002:a17:902:e890:b0:21f:6885:2b0b with SMTP id d9443c01a7336-221040697ecmr172506445ad.26.1739821859667;
        Mon, 17 Feb 2025 11:50:59 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb5aa216f2sm7856362a12.69.2025.02.17.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:50:59 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH v5 0/3] staging:gpib: typo fix and cleam up
Date: Tue, 18 Feb 2025 01:20:47 +0530
Message-ID: <20250217195050.117167-1-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

minor typo fix and cleanup

Ravi Kumar Kairi (3):
  staging:gpib:agilent_82350b.c: fixed a typo
  staging:gpib:agilent_82350b.c: cleaned commented out code
  staging:gpib:agilent_82350b.c: removed braces from a single if
    statement

 .../gpib/agilent_82350b/agilent_82350b.c      | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

-- 
2.48.1


