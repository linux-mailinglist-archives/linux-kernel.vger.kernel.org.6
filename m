Return-Path: <linux-kernel+bounces-212200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D4905CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B996B1C21E78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6B7F7E3;
	Wed, 12 Jun 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cweof4hZ"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273F182AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223381; cv=none; b=To5DrhmGBR+GaSFtmNR9+36Q1UBD77u3SEzYxuLpBermfRXAYSXtnqFkQRQdBNEtrids1LiZEXwpEeNB+6pQyMTts4pvv9Sb0PO9zFn37IVteD2RTKibWtUu9eiC7n7yGq+eSAJRAY7wm4pFiSucw6qLKKRt6cTGgYI3gICy6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223381; c=relaxed/simple;
	bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EX7gKJK8L6Yjm25bYVHCCjzP7vbl8ASQDMM/0o2P9Whk79YaFhdzorgDDbPwFDl/LXrKNyoHEEN67Pqoc56jzJEdlUOXzvDhlEGbUV5fD1+UIg9xyj7sR+x60IfbOTGAkUmbO/xCFUt/BV/xPXukRYCxh66x3RYPpmggETsKk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cweof4hZ; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a688e726755so5177666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718223378; x=1718828178; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=Cweof4hZwgGQFXeTtFdo5P+rvFGJq9REcLbaqPBDrc0NYnJSXWYZoVzO/UII6PjH24
         /ssFVKpffkKuujJe44w3+1Szn/6sldHnd6tbzM44yjfvobKUvvKeyyUe0F277PvCfrUc
         ZTURY8U82m+p9t3dDoZIG78QCqXsbbnNcuE/EKNxtu8AR40414HMgnkJyZ8hkLAaN01c
         hLJ6gHPOPgTdNfAmnntO0l5KqCU/GOg7S/YMsmykHF7z+h3Onu9Vm4Wf8r/ljuNlQjcM
         5s8tqxyvuCgo0YiHp8lYGJA5LDyOKsOY1/K1fKlDrnf5hw50mtlJ9i21nFIPSk0hn1KJ
         T1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223378; x=1718828178;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=L0MUiA7tDkQJuZk5WyQUFqmVWKk4vpg6wvo/QucUP3nrUFEtdy2RRwAsBQip6WLyZZ
         wTPhTqnRga26ip8VeMuJHSMg/YDWyY+Z/kmEYbbLqWJNhMNV+3Nmm7Ob4YpHPbyg/tBY
         pcUGKypP3JfFyCNNeqxwcp/LfFV9xw8Lt3LgqJILK4MfBfS45wE7HJAHb9onoUVKv5+7
         2gAiItqFNYE+23POPyvDSWyHC+W08x5jXRWl0u9vEIs/U5+epJ5/g5tPSJNHLDDGkv5J
         C8VfZiR7Sy56+yzBu3c+T0Uj19jOHiionzKZ7VkzT64PmIN75xPmc3gVWrZ358hkvYuW
         JXjA==
X-Gm-Message-State: AOJu0YwS7mXuMZpUnasaU+Rhc6YY4GOB8FjdVYeog20Ngcem8nYodpoo
	2W+x91s6y1TzMmHThLXDlN45m5N0jbgdlAHlefvz/cdm6E798U8hJk00iEpMj+o3qaL8K3MYEnc
	kmwvKBPHLClkIWJr2d78MazY8Rwwn0ExGpCmb4A==
X-Google-Smtp-Source: AGHT+IHnJyCLkTnq4Ps7C+JEM5/KRhXklWPCRNDPWCbfzJPoulXDTyOmeQ3Cpbyps4+K0jcl7W/FFkklBpUYeJFbYPA=
X-Received: by 2002:a17:906:e2c5:b0:a6f:4c83:ac71 with SMTP id
 a640c23a62f3a-a6f4c83b296mr116246266b.7.1718223377882; Wed, 12 Jun 2024
 13:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "R.F. Burns" <burnsrf@gmail.com>
Date: Wed, 12 Jun 2024 16:16:07 -0400
Message-ID: <CABG1boMUR88y1oDRrwukCANvnQmCkLvFf4WfsDhbbDs6pCf29g@mail.gmail.com>
Subject: PC speaker
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?

