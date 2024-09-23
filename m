Return-Path: <linux-kernel+bounces-336405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEFD983A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570EC283F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AE126C08;
	Mon, 23 Sep 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W28CslYy"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86993F9D5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727134373; cv=none; b=kt6wrPE0UckBsYyNnNzpI9oI12YnVbNtpHXySvj6ra3vAp5O1j5Jnl12sxUFXqDURMk4PN32xYXmpDa47dDhP90nZU23z+DvYcb+ZGGHYRaMRvBY06jzWwH+xPL8e2L9fjrQ5yZSDNmJZe3nrTOsfh3of6cP2uEEvOPxUV6ZU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727134373; c=relaxed/simple;
	bh=g/jzI/KyxN//eFCbYo0z9MLBROEAEJZWjDsoLKrMcpc=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=f6ARIAzEwF2ClUeyCFBP6ESb8GIQKKCpmWKbJ2mSaecpdNj6pIghRFUUoSojWYLrDZQBzmj8U5zgxRZllkVeoCgB5jISeTIqIKlwIhGBg7uVwoM12EZQSMsaCkShjmgDIDT1qQfYaOj7XGyRd95y4QQjK1JG4Oy1awpSjMmukmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W28CslYy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4069948b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727134371; x=1727739171; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTidrr6C6eVgIfFsaoNjyUeos11sgi4Nh6B5TkwURaE=;
        b=W28CslYyWi4Ors/+gSDCUEe3ez1YraJU3adDO6FxHVjo/6qdYwB6PymZMWKZIMsUP8
         bDGJTThYFOlOxisUKm5x1p2clLRSkl7VBPQNYeVNWYRBcRIwdj8ZrqOkxPWlx8QKS6Xr
         HRvbJnXjcETzilusT32TIJjhA4By2UvWjl9hFgWC+ZVE2Dsx1uUUN9tvcriXBRphQXfq
         eCzUOLY+6QR0hB/cqdgK/49N9O4TbyrJCnFXuU1/fDEeBySqPv+Fgcm0aTed0rZ5yu7V
         ZYh58sIk0XAxWqJIze85lxkh4Ucr7l8Wbl/+jUGjNxIhQvGYUpkjt+I94e0xd+jsnvz1
         1GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727134371; x=1727739171;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTidrr6C6eVgIfFsaoNjyUeos11sgi4Nh6B5TkwURaE=;
        b=VOfEucJbHyj8AkVpiUK3l17MyQj/ec9O7eK0fRM7OXXHjv5f6d7NE6r6HhYi7S4w62
         E/nugxYrEbCg4ZjA2hqotuKyUYs9nBIiEThhdb89nddtPZ2u2yayV1CiXv093NTIKh4R
         ERRyC+koD1yAMCTp8YIhgzjp69fYtydBl+cvIrABdOygdEWO/wjgvyBmXBehhYdlpjLu
         RuP+G0Z70pq6PrLMWWnNqeD+EnAHlzHZ1OWdehkjmCNsfGV6OxtAZ5bGOrkp+7GKoAPy
         3XxBjytKPFFzRfVTIWeZlXaNymH0Gkbb/w917AbPNxl+mVIGBAfeY3rF7cI53yabn+fr
         ECag==
X-Gm-Message-State: AOJu0YzJDeWIxxLjif51rCvSMIYAhPVjYR+GLjatw17duCt8GoB7xg40
	4Cgmc2txZiWTO7XTEix2t9YDp9eQ4cy6DPek1GPF9M2m7tnjRzZlXPtHkw==
X-Google-Smtp-Source: AGHT+IERn2B0Do/251RjjFGStRMFx31b85wCM0aV+hEf+PULNTxmhBZ3hpQOa/H3hhQc8y8rZPOFMg==
X-Received: by 2002:a05:6a21:460c:b0:1cf:4435:751e with SMTP id adf61e73a8af0-1d343ca6afcmr1646553637.16.1727134369797;
        Mon, 23 Sep 2024 16:32:49 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c30827sm99652a12.18.2024.09.23.16.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 16:32:49 -0700 (PDT)
From: "Van . Collin" <harshilantil3867@gmail.com>
X-Google-Original-From: "Van . Collin" <info@sourcemedia.com>
Message-ID: <d056e33bb351b802a577598476ee8ae0dde4e72e3fafe077dac6e628e8f9a5fd@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Sept 23 2024
Date: Mon, 23 Sep 2024 19:32:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Good day,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


