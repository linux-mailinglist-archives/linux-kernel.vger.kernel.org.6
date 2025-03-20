Return-Path: <linux-kernel+bounces-569273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EBA6A0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A59165DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4A1F8739;
	Thu, 20 Mar 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6zLvkd8"
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963C1E3769
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457334; cv=none; b=lGURJeqoaUmby17phCD5BzjVSpqNhGoEFaHETxDmBWRsl1GkJAQGKJNJDUlxw/kDx/4yS9hP22vgtxaXmRSFl/rbzj1uhjVt1gAx1oEbB36zXDJ5IV5A68Ye4uAsjbvnwx8BgYBFnMGpy4Udk8CIrgZ5Tq+5XLa0o3607+BQ2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457334; c=relaxed/simple;
	bh=V4Y5u3gvvflW3tto1M8laeE9HJ8srAnk7prGLbQ7wNY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CJPnHyIjGpvjIMMCpTWOCTWcmToIOQABHEvYnxuw6lzBsfq8Ot1F37xjQ+dw20B6/hICveHas1UU3soSVjN1dlyKfCaV37+y4PoToiwVgi75bLTwO4uKdybulAc74VwE5//SmdUSB/bIblqmNNXV2KObZbwLXECFRVTJVHQ2FKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6zLvkd8; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f7031ea11cso5324337b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742457332; x=1743062132; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MQK46mr1Fopo8fXsP8vC86iX9tHxR/GGUG2zvBU2nqU=;
        b=K6zLvkd8745tSyYtGryr+eL3BGTk4oiB02BNH2TkEIQ8eh0wWG9KCqk/BidU1ufT0K
         S5/L6uJpuE87+mJqAfzzWIn1qeBNdWVndLk2uW0UrOJVlKQSa+XsR2gYJaEfZe5NyBMX
         O70M7gJ6NuIsqnqgZJpri2Yvrw12tMHVJM07Dy0vEewaMrIjBcRpCnPQ4/4XbtXok/LC
         qIH6EUAcfZJqsqjucdQe/ESYYpmL+PP1OqNRB2yMxIEMSJ6TVg7kSXa1+k3SzaxFAXur
         1ZgOg97f5YhngcbcIelvu93xbcMPPzxgyuNZcGRQfvSq+hBznlFfwBsX2FnZFbZ86r78
         LbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742457332; x=1743062132;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQK46mr1Fopo8fXsP8vC86iX9tHxR/GGUG2zvBU2nqU=;
        b=VeBxtG1aVfuQjLU+ghOSwzphIJzbXNUgWO9e5E9liJDxii2cDC7z0gOV4Ay+6HEi3+
         QbPLHELfmF8D19jQt+BX7OPihPiGFmJTvcgpbgAa6brp1S3g8p5zi1JwHdNkUM5K3o2f
         Bcsg4tRDh4lasngXo9gYvrQMsVOx1eO3Uk1AJ01HJ4oen+LYDrjiOfDGaEcT0yaKGi45
         0X2MUeO0nJOcWq7ULZ+GcECVY+thj/80ARDY3cAy84cSWJ3rtMYzJz3bpCGl42VITcVG
         GPKgNhCjDfMr1TojuIeWwgjxBo7T6aLnkCjRpLeXAkhoj27Iqt7thfacnHWEqGI/JEAJ
         J2tw==
X-Gm-Message-State: AOJu0YzETDxU6AiQrUyuVdGjBE57ieA6yLpZdKiMDbv8EG45ot2yD/qN
	bXDp8JnskNpoM6uf1PzCHobPcvvlTf7MUFo94WBS8tXou+srv/p+gnxesUFlaN6GNvpnYBrj5qs
	C5dleILMEUtrwvVGKWRz1B+QiagKrWijHFO+Xtw==
X-Gm-Gg: ASbGnctxMtNoEe1Ojp6R21NwQlZIVbHkKPaOX7CY6WIKzFK2MNspUvyDvFhuAFbd4GO
	YMRoFRc3Qt2ZO1KjxGts/RsrMELYEXxJD5iiJSeMhnk13OhOTkiHw2mYjOc92Lz7+Y91MRUN2ea
	QJWUpqmF6l0gXqx0NUF4qkSNcEA5cK6B0xis7oxXbVAzswH9JWn41TCqYhnpeq
X-Google-Smtp-Source: AGHT+IEhL7aUxQKalfQ7ammgbhKNOiCqh9QDmDzptyBpQjkIDzOy7gcagshIJtnLwX2Tx8jJ/Cl5LLPeXm3KWCBKBbY=
X-Received: by 2002:a05:690c:4c0f:b0:6fe:c040:8eda with SMTP id
 00721157ae682-700ac594697mr26412407b3.4.1742457331810; Thu, 20 Mar 2025
 00:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Thu, 20 Mar 2025 13:25:20 +0530
X-Gm-Features: AQ5f1JoHJeR5B2mGg184_qzPqkak2tjHtauc7LmocHEEHlEzd8M7_61kjJbifzY
Message-ID: <CAFf+5zjHS_xA46PMJ_XgyV_dsXaX3yAfz3JtB_DggFVPyGaXLg@mail.gmail.com>
Subject: ".desktop" file example on Debian Linux.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The following gives an example of a .desktop file on Debian Linux that can be
used to open any arbitrary binary file (but not executable files) in "gedit".

Below the contents of the file "binary.file.desktop", steps are given for how to
use this file.


-------------------
binary.file.desktop
-------------------

[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Exec=gedit %F
MimeType=application/octet-stream
Name=Open_Binary_Files_With_gedit
StartupNotify=true



The steps to use this file are given below:

Step 1: Copy the lines given above (from "[Desktop Entry]" to
        "StartupNotify=true") in a file and name it as "binary.file.desktop".
        You can give any other name also to this file but keep the extension of
        the file as ".desktop". The first line of this file should be
        "[Desktop Entry]".

Step 2: Now, copy/move this file to the directory "/usr/share/applications/" so
        that all users can open binary files in "gedit". If you want to do this
        only for yourself then you can copy/move this file to
        "~/.local/share/applications/" (However, I haven't tested this).

Step 3: Now, run the command "sudo update-desktop-database".

Step 4: Now, right click any binary file (not an executable) and then click
        "Open With..." menu entry. Now, a window will open and it will list the
        applications which you can use to open the binary file. Now, select
        (with single click) the entry in the list that says
        "Open_Binary_Files_With_gedit" and then turn on the option
        "Always use for this file type" (this option is shown at the bottom of
        the window). Now, double-click the selected entry
        ("Open_Binary_Files_With_gedit") and it is done. The current binary file
        will open in "gedit". And from now on, you can simply double-click any
        binary file and it will open in "gedit".

----

