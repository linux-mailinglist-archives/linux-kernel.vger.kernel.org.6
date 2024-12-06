Return-Path: <linux-kernel+bounces-435482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D09E7865
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0972F1886520
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD001F37CA;
	Fri,  6 Dec 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SlQNnN6z"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE4194A63
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511548; cv=none; b=OW2s2bYT4neX/hiC4+wKHe0CijX8Gu5ge6nIk1I7kc/uJmbL8vK8y77UVpg9AIt2tX+L95sDQpDJWaSdSMrAm3jcgaZNhhqRXRg+V+tMkK+e/GUL5Kv9hhZyGtlpcgOOH+JSLX9VOm3NqN1j0bfL6aLdBUPnRh2wbCTAqb6YdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511548; c=relaxed/simple;
	bh=qvhNRQIAECvbL+0VG1lxnA7oddJW2svBem7/G/lqUJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxxrpHxXEiJcnziLJo3QM3dJI1Ir/yNf7MDvpJLLxk89OLhk7vgqr0r4i9pRJTtQL+3mhlAFUAhBn4XWELnHl615X1bRTMQ4k9ziI+wVOFFzqFOZqkVUZfJjIkPUEKaUnsYsrsbbZkMQ9Gc+h3/zxczO85oD8UMTSuoHJbsv17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SlQNnN6z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa549f2fa32so453150566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733511544; x=1734116344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvhNRQIAECvbL+0VG1lxnA7oddJW2svBem7/G/lqUJM=;
        b=SlQNnN6zdK4TkzKQ5ZQRq3kt/Y5/793dbz9MXmn6jNq5VWMGyr1fJggJQoZY6sK30g
         c0grksrdjc0XutwIXxUX715kTp169IMDTUunVs0RXCNJTKuoXji4eWsdOum1pwHuBQHD
         mEAVi8T17OAF87Hco9kMigM0OExGgrY1+Zf7lgLiNE/6OBD+Kj2JovieTBv6hXsjXpMk
         ZK7uNZDmvxrTUflEJEYnf9qh1dOi+6/Ieu9UCY5t/k0kLZ1Z/lHohIye9kuQsRHdKTsV
         PSv0wJVSrrHSdCbxvBKwxh1cin34ysT9SuTc2fmYEdav0fOJvZPjTErGBxDvRVFswvHY
         Feqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511544; x=1734116344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvhNRQIAECvbL+0VG1lxnA7oddJW2svBem7/G/lqUJM=;
        b=eQpIfEakNyAL1wGvbugJyDUXmCaH0uhi7t4Lz9MQM57v+r/JHjjJd44ub4eVoQysyk
         jhBn1X4j7TGkNCx6KFlxMBkYi6kU/ytmy6m8RQlG3mtxF46EleT9ZhQuWR97r0ebNXMX
         Tmu7Q3XuQOxuHiNk3C5hq14yET5y/aDkD45IYWpBr/tOSdd8DAQwOy/BuOhVvTd+F3fZ
         ns/yVtpPcXhiLzk5QyNjWp1i3Nor0BV3iWMpkMrQEHv0Rmyo8XlTCZR8Xstmn0kI9208
         VKjEUzxTikSzKZeX0XuDYpAwt+FDFddQ9j18ymptejxn1BacImJf79w3Si/iGW7RtsV9
         u9kw==
X-Forwarded-Encrypted: i=1; AJvYcCWPilje+IEPUz3at8YofMrGH2RaDwp+FAXg8PGQDo2FeWOhCxsUG+i9uklaIB6TUY9llk0eR5zOI54vF4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZ/So/ZoXXbK4tI822z9v2y1OYaAJD+qnmadg6NNgthfGiG47
	XScYZ7TtDdz5ZyoFWS9yWpl3+8a79InvTtpdCPKSgIMLDjNZwsk8UrFmVEIZ/C+KG1R0uWSVCb+
	4EP44pJur60iBE6pN+g/L0ZD91nYq0Hk+IpuskvDUGFQj6nvuFVU=
X-Gm-Gg: ASbGncuo5oVGzx0dmmpJqXTAQ2GxM2yTU6jMyr79m5mndI2kH2wWydQO4y8TV4nrsnX
	geSfz/GxmZEq27fnG3RawcBgma2yOrE4GYbcnCOamKTmzm/2KmBjFROelB3nA
X-Google-Smtp-Source: AGHT+IEZkQPyXCR4uOK6IK+7iMGtI9N2UA3WQnIEWS3PfzkwiaTdI0znHc1LZzLWnawwvXRfJnIiJQw3NcMECSV2HYo=
X-Received: by 2002:a17:906:3d29:b0:aa6:3f32:8910 with SMTP id
 a640c23a62f3a-aa63f328c25mr370447566b.56.1733511544014; Fri, 06 Dec 2024
 10:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206165014.165614-1-max.kellermann@ionos.com> <d3a588b67c3b1c52a759c59c19685ab8fcd59258.camel@ibm.com>
In-Reply-To: <d3a588b67c3b1c52a759c59c19685ab8fcd59258.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 19:58:53 +0100
Message-ID: <CAKPOu+-6SfZWQTazTP_0ipnd=S0ONx8vxe070wYgakB-g_igDg@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/io: make ceph_start_io_*() killable
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:40=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
> Do we really need this comment (for __must_check)? It looks like not
> very informative. What do you think?

That's a question of taste. For my taste, such comments are (not
needed but) helpful; many similar comments exist in the Linux kernel.

> I am not completely sure that it really needs to request compiler to
> check that return value is processed. Do we really need to enforce it?

Yes, should definitely be enforced. Callers which don't check the
return value are 100% buggy.

