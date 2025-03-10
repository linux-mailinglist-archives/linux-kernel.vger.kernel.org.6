Return-Path: <linux-kernel+bounces-553678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C9A58D56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DB16AEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5972222A4;
	Mon, 10 Mar 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvB+Xt1/"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260D221F3B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593307; cv=none; b=MVYnBtJ98th4fnHHukALJxMbTQHZFaUbs8tXMwqdlFzUwK061twJf1uOpzIQ5Doq+fTpWWaMr9sARIhcSRV4MzP9edMF4oROHwnVCgaiztOb+VAK7VQs43wAKKbczsihkPWxmhPE6eTGC1DbUDrCC0jjziVSGvV6DcnCVopr5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593307; c=relaxed/simple;
	bh=KfNFha9FglImQyo3MTrylzPc7xNkIuZhCWqzIkwu+ng=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cg3TyCceLt8hWBy+r/8ugTBathiXm5s9Rb4kBO/dlgDbOH0DvGOO/e2zKE0VdZKc7An028UwBd9kzFrbnTotTEOzqi7lIpRGnoz1PY7PYCFLeyCj5wWl2eWJhX7NpXUxCgA8VldQI0P0pwPHVE22V7mS+DIrukfR60Bg6FYKU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvB+Xt1/; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e4419a47887so2991984276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593305; x=1742198105; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfNFha9FglImQyo3MTrylzPc7xNkIuZhCWqzIkwu+ng=;
        b=cvB+Xt1/q0OxDTdoXHdh215SIg9s7vuBukYEJBu3KPhoEDKh8CL8v7gBIcuOxecQ/A
         qAxYcNsCogOVFNUFwhxIytylKywfbdKt0v0WdIe6AUEJUkG3V++79P+k5oB6I3ZNAMEY
         W9h8ULuhdgM4AXxPWVdWnFeHBSym2hQAFxBwF1AaVpRewxeL2LbwHqHt/UNTcggX1pI6
         zivbggqGLnwSE9Stpgjgqed7pF+RpbgFZvZsG/b6hxNHgnvPjiXeszChlSsbdH01riJ7
         rtoh7V5uayH7epmwByjyLhxaHZIdq/0ppryO6xU36uu3zZUwy03t7gFeExUdbxXayh9o
         kb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593305; x=1742198105;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfNFha9FglImQyo3MTrylzPc7xNkIuZhCWqzIkwu+ng=;
        b=nQ2akno2kwYrPGu/wyg87bGgqDPAmjd7o+oZfqZUEffVfyvVM+Y+MdSOyBFwds5V4k
         SXXDzbf0iR4xK0S33yYDycqZU2gv4/MyvoOSrdwzxn+l+rKtmy7RZ+3ZlBg1mk1bZz2f
         que4cTDD4sUCTjW0QZXqZ5P2yG+gKe1hLXlclXg/9JLXpafxGjnAEIuURlylWPDZ3kDm
         +maOZkb90llS8Xyxnxtf0QXPWzsbr1PRcgN9142RGeqBEBybV/GyKtGZhWZCxPYQgBXd
         WnSB6OtpYFfCYHOhkIFZNZuDperPSr2sQO8ijCawg0wiBpf3svc72XMCapejbdlflTjD
         u1fg==
X-Gm-Message-State: AOJu0Yy4WqJvz5TMHNazVA+e3kdeFGg5eklFcNhmii1f8wqC7gmrVdlM
	/aYf6rtwITF0hmtsEM4g3PF8NZfEyFXVXHVpaC8NWRFjN5bjoze+pIip9iNAuRJ1jJOafq+q2r3
	7PfDLvplYjY6ws8ap0vKy9QSdSlKgVbQyt+AeVVU7
X-Gm-Gg: ASbGncvEq30UzsV0uPuZ0NDLa+Vip2ztwlFBrp0lHC16SaOu8LiNVy6p89R2baX90Sw
	DKOQZ0+CDDxTXUWtepvNnA/kmCEhyMAGSPxoxMoawb0PkKNIow2IEHg7Sy5oaneZ6X49AN+8ueQ
	peNtgsqMyinrIPe39u/25bIvKlZ6HbKpdp/sLAynob+cYgTICjoQDI4UR2yobWngG+gOAa0WY=
X-Google-Smtp-Source: AGHT+IF2O3b9Ot3GsTlbfnfW4Gs/mElXeNyxUah1mqNTB0/ngumpLiTdnjAVqU4htpTKn4DNCPA30+CH2smLSFXYF8k=
X-Received: by 2002:a25:5103:0:b0:e63:6f6a:ab01 with SMTP id
 3f1490d57ef6-e636f6aac84mr8955836276.20.1741593304783; Mon, 10 Mar 2025
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Mon, 10 Mar 2025 13:24:54 +0530
X-Gm-Features: AQ5f1JpuE-6xFaKSH2UA93S1srRaYs5HctM6hkpKtOVS0iJhAgNSL9y1mU6h7hE
Message-ID: <CAFf+5zj=KmBG0Avqy6cq9qtpGKR3HnYNc6rK6y8B_78Ajt4RhQ@mail.gmail.com>
Subject: Catching use-after-free easily in linux kernel.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We can catch use-after-free easily if we do the following:

kfree(x);
(x) = NULL;

Now, if someone uses 'x' again then the kernel will crash and we will know where
the use-after-free is happening and then we can fix it.

Regards,
Amit

