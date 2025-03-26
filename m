Return-Path: <linux-kernel+bounces-577227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7BA71A19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0EA3B8F29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716E1547E7;
	Wed, 26 Mar 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="O1u+Iuf7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850113BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002192; cv=none; b=mvMQUNdhdVCOBGeSZi1ErgNnfZWKMzRBAQdqEoxmu+rH+QpqDo28RKQeX/DAH8SISNeDisjki2fmuKrdE9umN+z9gT1M34JhIbmgZoGGpXpGMV/Xsn+m6i4+2Do4xUN32zcEhADGbhkawmKeIuh8H9wZBdKsWLqI2Rb6TV1c5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002192; c=relaxed/simple;
	bh=6/tmUjkepmdTzowy5RCSp/FOFMFysVqBHy/6odwGvjw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r+SWEEqzuf0mzg5qG2hUb9ZumVFqybReZZJnDp7meOK0zOpXlq2WyBz26TKjqeYwHwygvy9SU1LbHQi5tKIOMZRBGz3OzsGheUz48vgqwaeHAXa4OoUhxohMrz9CY7sG1J2jBJpwceHk8mkK53BSRfKYavoghMWeQveGAi6KG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=O1u+Iuf7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476ae781d21so60707091cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1743002189; x=1743606989; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/tmUjkepmdTzowy5RCSp/FOFMFysVqBHy/6odwGvjw=;
        b=O1u+Iuf7wUsbI3/ekjDqSJakWmN5tAMHXzp4o094qNkKB1TYUh/KE+TxuMmHjwpAnl
         8WFLHf0nkkSoSXjWSJ5dqY/C5QhU0yDUFcMkW/gt7c7St2SpGg+lHhFLbtqdoC2BqPK7
         ZhEsOCimBistFVdoeOG/+DG4dr2sVJ6zTCDUDcQBnLzuISbrbFHxvwKXWZDijn9JVrK5
         2zWd4/Egn0IqmadIZKYrfWq0PsPWCaD7iJHM1xVuwv76372PpudjY+HXG7Ce71Pkpch9
         yX2dHqf7U7dCeUa2eqMWfzXfvhK4lihSoOh6kNdwZpz3hOb7B2gaEzhh/3NlyKiSoXr3
         SVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743002189; x=1743606989;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/tmUjkepmdTzowy5RCSp/FOFMFysVqBHy/6odwGvjw=;
        b=EHce1Nk8yjcuoO3B/UNkzQ5GGeBnWLyzNp0dQWxVCXJjsRlDqf0T1J51/iY6E6PcBh
         W6cX3g2P4KHlzbNkSD72+YTiKzCC86ejaU/+K7Rtj16R7wfW1/nz04xmQbeHpWUDYlY/
         ax3nlAP6dmc14omURZyWZs+eolIef5uEyrSrUMq9eI8HB2sm1bFi/w3oWD9oRhA9bI/n
         4kOph3Rjde/f6snJSvlDPNscLgQutslHxD7/WGGBnSVg+sLnrRLTk2gQATuQOS3rkqxT
         aLnG8UHV8Sgd/EBGPJEcTvGXTCdP+t7n1aGRjhtcFTshte/K3w2vuift23aCMZqWVx5q
         zTNg==
X-Forwarded-Encrypted: i=1; AJvYcCXgCFPqdTM6jLWZYQPDBrS0fi3xUmKg9m5FwVt1pZP0upndjHYBxDpQ5Xg+XGPownT/S/fvGy8WJR7IeGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYFiQiUPkuxsmfYl1dfXwwfzcs8HTBsXKaHuGfZQ/9GDW9W++
	wi8ygeYTOS41odIKpEck0cKdHbytjLh4DWbdzOMrvX+dS6JpqdGHUprlZpgIzFqA/EkLrb1qieO
	ckvzv3RLuhPFO8i/AcDo5ByJ2SWvOdbQpEnbC3xfsaliq2MjbjyQ=
X-Gm-Gg: ASbGncsLmnhLzKF3ds4Yi3baemfsWcz0chP5Qks0T6dAyH8nnAOVgb41AnmGxnyDRHn
	FGkdVysJ2Gs5pQG06llaMm35XFXqyLo/ncXXmJvOD0oufdbnSMZnV5oT8MzYSQzyQbo15XvZXoE
	0jFAaclLustY0cRLVDQ/NVye2f
X-Google-Smtp-Source: AGHT+IF444WPyCX+yROx2jWT4J4khVBDOc3bBBzi/GiaYlKYhiLfVfnqoUSmQ76hFA02Se/jz3+LBYRyU6WqeHbf3Nw=
X-Received: by 2002:a05:622a:988:b0:476:8225:dad1 with SMTP id
 d75a77b69052e-4776e0bd62bmr1035151cf.17.1743002189020; Wed, 26 Mar 2025
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rostyslav Khudolii <ros@qtec.com>
Date: Wed, 26 Mar 2025 16:16:17 +0100
X-Gm-Features: AQ5f1Jr4-hLgxzdo6r2C9JDB8osKAbc_VuF6MAOsuup4GGscog5BIsBJq2B26k4
Message-ID: <CAJDH93sBkYRkO0O_4nAhF4nLUFK3ufw=tPLdbvGzoWLs6Lo6Gw@mail.gmail.com>
Subject: [media] Subdev driver and V4L2_FRMIVAL_TYPE_CONTINUOUS/STEPWISE
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm currently dealing with industrial camera sensors that are flexible
when it comes to setting a frame rate, and I stumbled upon this thread
https://www.spinics.net/lists/linux-media/msg98620.html, which ends
with a patch that adds
V4L2_FRMIVAL_TYPE_CONTINUOUS/V4L2_FRMIVAL_TYPE_STEPWISE support for
subdevices.
However, it seems like the patch has never made it to upstream, and
I've been wondering why and whether it should be picked up again as
it's something that could be beneficial in situations like mine.

Best regards,
Ros

