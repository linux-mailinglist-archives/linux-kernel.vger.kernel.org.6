Return-Path: <linux-kernel+bounces-180581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187958C706F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6112282B27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFF4696;
	Thu, 16 May 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD48ujYD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247584411
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715828047; cv=none; b=NvxEEUY65uMDLyl8UKq6zLV/uFfEFIkaaeZeDQargiahJiJAJJqIAt8brhJ0zu9XeG9VGKFGmmluI/4hgJX2PxXc1kpBN9YfbXDutqO8xGN+o4bp5CMGzF3eGuHbeSZ6K5cusnm+41PxfVdWypBvcXMSsZKWryq0CP6hT9VdkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715828047; c=relaxed/simple;
	bh=h6W3K644TyYTLD+ElFlD0WBXJIXzaEy9/xqUC9eFq7g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rar7snfIfKMvfwnZ7+HNH7FiygFojaZo+tu0EwgecvDHnU+kXtW+dWsW2dnF71jYsI5TMkjaboySxFnNc4nnu8sLBw5atgSG5KH750/ehDYiyolb6O5Qi14brFQqRNsgfVtKHcmEtZWddzaRd2kg813PDI8eeaJ+UpavtGfV1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD48ujYD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fdc9af005so397205e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715828044; x=1716432844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc9idQrdbpiwMBSt6L8BxJOv1+2OpDzw7KOALEJ4jJ8=;
        b=bD48ujYDW0UhrpPtY3knHNivFgaTUkCERzbtyBiTzMicaD75ZHaaH7dDnXexlL4dmP
         OxhAXDEGRFHUYrg4YcQ9Z5N+Ub50RpZ+/+c7EkbeRHeLxh2iAKEQw3tsHIUI57VQoArL
         BYMrvf1IRltla/ECl+sm0Xu1kzOHPLYsLYdnBgsVtdWfjxaALbFnQEP/0bkVNxJU+qCK
         aKdoSeIlXN4D5SLmrSt39Oy4VAZHhM+hbKxViQrx0abFEKdO5QO3BFcNuDYF7274OQNF
         RzwcmTmpONTa8qyyOpxVyCYrJGC2J7k9TTx6cHAKFdy+NGCqOh/6RYBkJ5C4azfSNaoq
         CF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715828044; x=1716432844;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc9idQrdbpiwMBSt6L8BxJOv1+2OpDzw7KOALEJ4jJ8=;
        b=i3AFIr2ELba+qs39Hfo2Nk9cSC0wHeOiYGfsaBLfuOI1A1oONfqi9yc1nlhWADN7Up
         VQqF+R489FR2YF0mFpJsxDFLE5+vrSQLQ6kHM3G/RWtxVoO//jRHD2B2T5ye3FnFVFaq
         us34yJ1udvD2Tlw/3XC166RoV1+NdBqyK/qZoh9LbW4zRsGMhEm71u1LKAUF6SzLthKO
         ieKQqXI0YLdT0V85JF6mn79o7TDoQU1ze0x17l3DiSFUF852crACxF2sLoksmZxtilh+
         99SnpCVtm3FzBv9qi+4aDI3je7NkUkJFXKtbqhK30zkTCNgzutCpo5qcQ44cmHsL/nQI
         W2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWU4SCe1AWxuU8+6nkvUiPmJYuF/shmLv/xoLiHWPdW3q84pue7Np+cIzynVbRMZ3DrH4aHlUJvdWlYC+e2ygAr+Gr3YdSYcLrDJCgl
X-Gm-Message-State: AOJu0YyBrR9Vy1qCTszkpRZixyE54KGvFhO1r1NnanCaRoDMc1fqAPni
	uBm853SmQC7NcpBRQ7xeAS87pdPQ1bgMKhJr73xspVLovtqpR34szFBIS5eVQqUyiNjcPnOuCFc
	koUS1ZZaHwENol8bFd1/Giza/1aM=
X-Google-Smtp-Source: AGHT+IEIVpnumLI29ZUaA8RK49U1gN6tcXn5ifUPu5C2wHhtI90oLioFPwr1i+oB405rRZyrCbG9Ny4XUqRc0DzrcD4=
X-Received: by 2002:ac2:504c:0:b0:51a:df97:cc8d with SMTP id
 2adb3069b0e04-5220fd7cc70mr10958319e87.26.1715828043991; Wed, 15 May 2024
 19:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 12:53:52 +1000
Message-ID: <CAPM=9tx_KS1qc8E1kUB5PPBvO9EKHNkk7hYWu-WwWJ6os=otJA@mail.gmail.com>
Subject: [git pull] drm urgent for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Here is the buddy allocator fix I picked up from the list, please apply.

Dave.

drm-next-2024-05-16:
drm urgent for 6.10-rc1 merge:

buddy:
- fix breakage in buddy allocator.
The following changes since commit 275654c02f0ba09d409c36d71dc238e470741e30:

  Merge tag 'drm-xe-next-fixes-2024-05-09-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2024-05-10
12:41:34 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2024-05-16

for you to fetch changes up to 431c590c3ab0469dfedad3a832fe73556396ee52:

  drm/tests: Add a unit test for range bias allocation (2024-05-16
12:50:14 +1000)

----------------------------------------------------------------
drm urgent for 6.10-rc1 merge:

buddy:
- fix breakage in buddy allocator.

----------------------------------------------------------------
Arunpravin Paneer Selvam (2):
      drm/buddy: Fix the range bias clear memory allocation issue
      drm/tests: Add a unit test for range bias allocation

 drivers/gpu/drm/drm_buddy.c            |  3 ++-
 drivers/gpu/drm/tests/drm_buddy_test.c | 36 +++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

