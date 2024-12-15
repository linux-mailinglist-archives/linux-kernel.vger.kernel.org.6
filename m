Return-Path: <linux-kernel+bounces-446462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADDE9F2495
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D8D1885DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E2440C;
	Sun, 15 Dec 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4UdOU4J"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E0A937
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275979; cv=none; b=WYgev36C6jgkcYn5jolLaXPSVMmY1ZslYPHWJD92YMSCbZLmUQrWSmkvUJ/9RBu5fmgkK4+AF0I+M64bwcmpyh0v/5BK2McJRGj6bXfTCM57+xhH8WikG77gh2cWmSNodG/bRs1g0QVOsgEFh2i2zlH66PgU1XaA0e82CYj9hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275979; c=relaxed/simple;
	bh=Hd8UwqLBiDS/o9zSBrlm/wmY8sL1LO2jQeUkT9rQnsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R2WCkGwPnMZZ2DXzyPVpjKifYavSENKBB70FC7ZKtfO6VYZ11Iql6IDoZ/Pc8IEasye5NaPgho2FunmrXgfJJFH8YYUc3FQTiAOkKhBXyYu5cL0KeNryONjKfuN1T2fER0lZtrxMSv7KRvAqDnygPch7/Ig7Mb2sdtbQw/QT0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N4UdOU4J; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa689b88293so359184066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 07:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734275976; x=1734880776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Fx7qr13rE+Y63Oy8FBeit6xKfLUgp21eKMLVhVGd4=;
        b=N4UdOU4JgoHvBXya2SyyojEpzHQAthVQeJSoIGteraPANqV9ORNDAZX5RHx87CvegW
         Fx7GMuXzJq8vEzC4+oTB1Fz5LEVQGi2O0+gWXnrqQkMpmtHs9WNKBW5GifxCSmJ81ADO
         uSVD4P+OajIkcgFJnkr9rkES0vSkgdZFwlEcpgcp2kFOsqfzlYCUnPAYBKHwv3Bl/h6D
         hcISfEbG6b41uXfBNLAnMos0cH6Su4NgF1A0mFOHDpZMxj2JwjBbLw+nH+EzHHTHQR2m
         MPSaIQR8TIGzRppRs4vhHq5zrepr/AfJfJfkPZVbApMxe9RGmgKL0I5zSk+EWmiQS4+f
         PUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734275976; x=1734880776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Fx7qr13rE+Y63Oy8FBeit6xKfLUgp21eKMLVhVGd4=;
        b=YtY+udF3o5TMh4xclzzcwodV0o8+bw6mnFuZMW46d7bL/fM6moRPJQxuIAi5yCyNwk
         SDiw1ZDI73F93oX/wNCKntaGTHB6ZgSAHopAsTgP5ULUsGZcQ3ebZq5GpgrIQK2ZOUy/
         E8LIrnrTbPh7AAVZskJaf5kbovtvwS4gZWipi9boKalhCam2L+iNGPPzD2Xp8OcnE98G
         RzXf6OE3s9bpcAdZbaPoKazlDCn2Q51BHODvB1yTPJpPu04WPwS41qRUUpPnVv8UvnJW
         Kjt/hJy13J7UUOA9GU+bJXwjOydA+QH5yc/B1u4qbgQ31JMz4o/f+8B0KTNoWXqlctC0
         oKFA==
X-Forwarded-Encrypted: i=1; AJvYcCXVpTRTvkDSD6K9x0y8BjIyYS73E+YQpNek02UWIpqk7TGeLK4dve/FYCUgqB1bziE8f9/dUwCL/Oe5GbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71Sv1jwT5sMaXBUZChCMLv9fc0nXg4E1NUz1rIJvWG14RPdt8
	DLEHYbJ2vde9FzmWhM5STXEt9loOG81PW8yAjEUiq6ZjkZARg8SSFFon5XNSetU9JVyZ5CWhjXM
	wQzvNoUAdnE+b7A==
X-Google-Smtp-Source: AGHT+IFiXwE1BUJwVU9izZNwfSSw++NLFItDdj0vzkc9h88hGSP9dEnJfaUslOMEsVkgKFNxsPdVA4tdbWlu/co=
X-Received: from edbek16.prod.google.com ([2002:a05:6402:3710:b0:5cb:85ff:8366])
 (user=ciprietti job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7211:b0:aa6:8ce6:1928 with SMTP id a640c23a62f3a-aab77e7b934mr1003575766b.48.1734275976390;
 Sun, 15 Dec 2024 07:19:36 -0800 (PST)
Date: Sun, 15 Dec 2024 15:19:20 +0000
In-Reply-To: <20241114104625.1735182-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114104625.1735182-1-ciprietti@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215151920.2228190-1-ciprietti@google.com>
Subject: Re: [PATCH v2] sched/smt: Call sched_core_cpu_deactivate() after
 error is handled
From: Andrea Ciprietti <ciprietti@google.com>
To: vschneid@redhat.com
Cc: bsegall@google.com, dietmar.eggemann@arm.com, joshdon@google.com, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, ciprietti@google.com
Content-Type: text/plain; charset="UTF-8"

Quick follow-up on this patch: does the new version of the changelog 
reflect the change you suggested? If so, is it ready to be taken?

Thanks!

