Return-Path: <linux-kernel+bounces-210192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491809040A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483211C230CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDEB383B2;
	Tue, 11 Jun 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShPMx937"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB031EB31
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121534; cv=none; b=iZTEncwgu2mkkK4wKdCJymw2hBcj2V7JM2v1M1mGM3iFwzfmNb5Lxvkhq+VJ3fCa13ijNeLc9vNyohQdCcAbsaF4MpXCv9vAsHN6h/qe0kQSmzTkvSj//lpV8tH4HSh7WLP0R+CSx2yQ0drlQNZ2p/uiJbnmFaTMd/cmSkBTYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121534; c=relaxed/simple;
	bh=dwQ9Z7PhnhiKQM1zeYwW5eh6xKCIFDwVYCzL3vkW0cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJo9pOBg/PmtI2Yd617zk0neKye+l4O3XYviiAhmOBrLaRWcxkMK1LlLvaSX+MtX/G3urM8QL7vdpHwfE05lyapdlRiCOioUqxam66YhpJFViwKtz+gwTKhHYDFG7WW4/8pW29GzeCWYMqOHRwCkGE4IlLzbcXS+LOwg9i0bztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShPMx937; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfb05bcc50dso1107266276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718121532; x=1718726332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwQ9Z7PhnhiKQM1zeYwW5eh6xKCIFDwVYCzL3vkW0cI=;
        b=ShPMx937HYb0RmMb9p3V26d2fyTex9kbF4PuPLKsmlJllL69iDxZSamOu+1GvMhGec
         YrgzBMX9FV4GxlzP3SFTSaG+s7QmFhMwYXDsaiueRlvZhj+zCN/lUJXbw5EgRHzAwVQK
         FEDqgpLzhDHzKmj2OF/iDsc0AS/JwUZxfsr2As0l/udSUpWuiGUmYHlacbwi2hwat4hH
         OAPeNBE/AirDQ0DJ5sN4iukb1oYZQba84ravUoj/+wdBkN6Rjl30V+ZlNDCjtKR0UOQN
         DdlO5dcFKsQQH+D1ShuYqrIPMpgOx2yv5sMLhCR4piQE3mS1rWTH53iThP55vxmN4Ei0
         cYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121532; x=1718726332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwQ9Z7PhnhiKQM1zeYwW5eh6xKCIFDwVYCzL3vkW0cI=;
        b=mWRff37iVwQzxnbHrbTl0xHjaKHktUVuIZK9vPT6fA5A6hpbYOEUc25QAM1MNy8rUO
         4oGcDNPlEySwiP6mdGZeYSTBggT9Vmwqipi2EqcS6B0o/5cT1LlTAWrS3jAvnsSMbn0X
         KCaqxDlppq1hKu4qQnKVkUDwQEInRo48akYiAgTH1efuXzxFUJb6aMSBXmxOsPf4Mtg+
         GVHe2eY/0dUPnkB6OySCvMAre35rKLrqrq+EnbDlpRlToojo4vf56F6pfKhIQy7xMTNt
         6J+o+vz9rvePfiSP2J5OTj40ASDIDnt66T8U3nLshBLhXkbgjo1UOQKCW1maPSch5R6r
         vxpw==
X-Forwarded-Encrypted: i=1; AJvYcCVjjd8mDQmdveeJnfTa5xRSJlGhWhJSRnY7SIVCkVeN33zMG11eFERpAo3YL39h6755SyL3FSQc6pMZX8HWWa03bqxxM1jC/LjSI2YP
X-Gm-Message-State: AOJu0Yw5Qn873/Qp7SCEentMum1rCsQB4hox2vaexV88hOO/nDtExuu7
	Ka6No0/btj+4Pl1k0pMyHldZ0VXIddsZj4s2tab1jdNE9xSL/3b0lgIY1LyUqdj9C3GZx8O25q0
	E8Nc5A6WH4fitJ35zOdzXLGpMPDM=
X-Google-Smtp-Source: AGHT+IG8iTlCW2I4xRkSk71m3tSMV+qQ+hsOJngulEEMD9ee6COFRtMfgS0BS+7YBJSgGO/39bKayc30C4ZvCNWM020=
X-Received: by 2002:a25:bf89:0:b0:dfb:294e:d16c with SMTP id
 3f1490d57ef6-dfb294ed322mr6192369276.59.1718121531679; Tue, 11 Jun 2024
 08:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
In-Reply-To: <20240611024516.1375191-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 08:58:41 -0700
Message-ID: <CAKEwX=M3Jk9oKVffRn25xUEyq=ufzxs=XyhfjSZ0+UoB3oxrcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: zswap: rename is_zswap_enabled() to zswap_is_enabled()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 7:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> In preparation of introducing a similar function, rename
> is_zswap_enabled() to use zswap_* prefix like other zswap functions.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Ooops this is my bad :) Thanks for making it more consistent, Yosry!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

