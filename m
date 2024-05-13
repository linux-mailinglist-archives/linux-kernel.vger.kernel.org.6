Return-Path: <linux-kernel+bounces-177761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E58D8C444D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFD91F2191D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359CD153BD4;
	Mon, 13 May 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbGm9xZq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C557CAD
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614410; cv=none; b=l0VF4yuXivePaonfbO2eYF6/P/ExLCEEuc2vXAXvcaztHEnFSUYWXqBgJ/BW9ZRjpUVHHRoIgNonTjoILynj5U3JEL5KudQf88GNW3no/kt9m06wUPIaMK0SIrPSL/pjO45ckRUcykNWa7Amijt7FZvI1HgsUxxI64OfdZ8ma4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614410; c=relaxed/simple;
	bh=ju17aXImhRO8hDxQtNMhltEL9/QMGtqlOCRNxBQsgR4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sNi1o1GdBoOy+OzZydO/n+StS3JZE0MhpcX7YmJYPTQt/5qgyy4yh7giM76dDkpTTri4tUyFqu6idXC/ek51KNkn5evIEpvqY9hMBFxabbAdFzN4D9veD6sikAEV5ipK7jQPerNegcFpzvhUBWFAJItARD6wxr+fclIRLPEDY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbGm9xZq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so52638811fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614407; x=1716219207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ju17aXImhRO8hDxQtNMhltEL9/QMGtqlOCRNxBQsgR4=;
        b=DbGm9xZqwCpNOimELdCYy/qFkuHrQxNvHg/Yf7ZlYWq8eYe51yHzDFpf5ucz5q2TWL
         L5aKvgKBm6i1mocYSqjw+Asiui24wGq+OEqckaKeNK9UnisnjWu7yZU1O+rv+qMTcbmw
         rkuvRMoN06QZWs6+oRV6+pf3CZ1DkFi1kZ5W5I8tHksv0GTiJrwo0v9rnTzaSzi2fsB+
         /FhhRQXaAecEBL8F7mmLjUqGGrY7p+Xf6y9iRbpAAI1Izsg6F9Eh8ucA9IpcF0sSSl/s
         emggZo9GMdIgA0bbPuek9HfvYIrg4RN0q+U76ytNsAeX6VxbiOFBpyKe3fo+9Hw7lEUF
         FZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614407; x=1716219207;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ju17aXImhRO8hDxQtNMhltEL9/QMGtqlOCRNxBQsgR4=;
        b=vskGiciZoacl5fCgPUCwNPGitl8+nrROJETlPjwLwXkbvlZgS4IPuhmRL30b8ypAs9
         kUNgIGfmjLYgIQcQfpMW9XeePQnT0gTghcsUt+B8+DMh9HJQpZbo60X/XLxIh2gAL97D
         p+eK9J4n2+fng8Vm5ZF0LCEhes5aIgRXu/L7jdMePAT2kYtQnhO7HjnjWw/7+owgglMj
         GORktWuv4dnKRTZLEVbPBkUPc9LMkwvZexaSUs5g/uhjiV/FzJfHIaTREfeDE466KH0l
         Iv9b9NKDU9gthwpq0n6HG6QOYmRE25NuCv2GW2HBlUMvT2BTjqeXQiUAPlWTlby902zN
         R5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjVxsn7M8MnVRoP/LELib+QA3oxvK8AiMEbrCUMM+8CZGShS7Al/t0ocymfOXN9HS85Oy+mhHUWbSLW3npY8lCHgOe8re2kjGp/LCW
X-Gm-Message-State: AOJu0Yx6OuJrULhxl3cPThKSx3eL0rMgjQomJKL0sN0eFtj05FEJNJo2
	l1foqBKTtdDTV4f1RioTvrfgiCwLbPTaF4u6Ts6h6IO7PKrXp7r0K9Tbr5lAazBozOYa7nHAwTq
	TIOcd6Dv7lHSB8+8ScqMvSLDMjBAMVA==
X-Google-Smtp-Source: AGHT+IEPMVx7fryPoh19mU6KZM4D9No2ZyJ/m7SiCihtox8QnFiIY2f7NNojY8dXinX3op+wXolL25qYWHaDvaTjV08=
X-Received: by 2002:a2e:97c3:0:b0:2e1:f253:152a with SMTP id
 38308e7fff4ca-2e5204aef69mr65781901fa.51.1715614407004; Mon, 13 May 2024
 08:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Mon, 13 May 2024 16:33:14 +0100
Message-ID: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "OlteanV@gmail.com" <OlteanV@gmail.com>
Content-Type: text/plain; charset="UTF-8"

[Corrected emails for f.fainelli and olteanv]

