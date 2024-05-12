Return-Path: <linux-kernel+bounces-176945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE18C37B3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFC2813E0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE674A99C;
	Sun, 12 May 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN0tFug0"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E017BA8
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533842; cv=none; b=foSUcK3SD9BBwDsDxyZjNICIurMW8ECyzzojDtcfM/5deap5w7LxBuZ61cdk7wlh+H7VbYKr+amxLuOVKjhvSbJarOp9wK1Dqs6AZuYw1CoJ+hmaYPbxf6dyHutQJo3R2jWlatspn7COY+vVCFPvF5Zg3BpeCuBJoLjxFhF4jXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533842; c=relaxed/simple;
	bh=wg0YA5FfYfZ8HOevPWPvq2wELw/oMeox03SJfTjBQlE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NgEwJHhDmklLYL6i7breKxo89E8QTJcuAMNanwXq3jV4WQkxlLnNx5sUoDXCHn9s/2ihw3HP6Dzg+N6t6y3lsvvIO0RC3pDIa0XES+RvWcPTTbLKfe87cvlE+79mBv1hBsIU8hBQEhrWvTsFpardw2NUXKRUzB7/UxjcRCrqmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN0tFug0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-deb99fa47b6so4160947276.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715533840; x=1716138640; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pLHWq8okXTT3owCXn5JBWfo9jEYt7ZAZy8OoSAdnKBQ=;
        b=jN0tFug0QKBsK6cP/owzz4/rEuOWVs1oRH6naqlg10jDbYHnjVYWvG6bj4PjPrreTp
         BW4XgTo8ioj9K7+e/ke2u87cibjecrnZxZfRnTBbdq00vTVkAT28fzKoA4dzVPfVaS2W
         KACdGaqkLwIEP2+DwjFyyYW8PyMc73XXFNvELCCNEHsiSqpp5n0cgcHtkl0NYkmAMwIu
         zR2134fHKj5RjVsCp6Ya63597G6pd375r1UnrgZSZf46iSI2pci8d9eVjAhOncQAKHic
         vBYGRbNisWlFZ35Gw7GVXmqpp/Xzwub1X3oiI/VKDlRipfAgszScZvE1lxEbpDB8uWik
         WIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715533840; x=1716138640;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLHWq8okXTT3owCXn5JBWfo9jEYt7ZAZy8OoSAdnKBQ=;
        b=UyTShtaT22Vzhc5Q+5YP34nWHK4yQRhXmjEgOtmiCQlIoL8pAoOvqmBdo2ZqRDCt4o
         Flzz7unryXg1bwn0yWjgvHFU3pmDs3XRsvvdQYhYALec/LPDw8XurCgFA55nLcjJneh7
         1pIqk5IJKG7fLhpWx3A7uO/hBKLZZr6PRx9uWZULbtAsz4zyD0pCrcsu08zDtS+WSVvI
         1CSv2ay0thT+g9KfLvd71yP9dAlPSs79msCE7lxfmY66RrLTlwWkAZZBphigpEExMoop
         RYr+4LxNLIW4/uEcPti9Ig3f4nfQX5heS30w3cGKUbK7RMfNcdijRV2BQkPLrKenMRc4
         LriQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbQsE5y3Dnq4+3MQl4rFF/6BRthzyWMytuEeIf+B5IFbdZ5AAZi2xW+qEN/cCZZGsZACvSHMMxJODdR9sRelGS+0gau6K4IuN5s2Sn
X-Gm-Message-State: AOJu0YympZx3D1vzfQI1aVf3FN7X8hEss97xdSuA2fHY3PiZDSY87v2J
	QE5uhd9WiSxR3zO7jp7ADpjS9tpks3rxGlGy4khjpW8rko8fclqHIhyhtvo+flKvVUl+gv5Ojko
	uyN3J5qKZd5n0qCdC4CbAai03cOhbUkWB
X-Google-Smtp-Source: AGHT+IEDpeH2dfC9SObBecr1zT8K8XIMs3o18jZrmqGxMDkioKgPjCFNyr2fTOudsRkmNhm3ncX7ibtkRCLblKRlouA=
X-Received: by 2002:a25:8102:0:b0:dc2:41de:b744 with SMTP id
 3f1490d57ef6-dee4f338307mr6344893276.32.1715533840227; Sun, 12 May 2024
 10:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Sun, 12 May 2024 22:40:29 +0530
Message-ID: <CAHhAz+hcVRU8=SkkoHGRDN5zRvB2HY1-1Y2NQmNwR=07ObSFrQ@mail.gmail.com>
Subject: Inquiry Regarding Handling of Kernel Crashes
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Community,

I hope this email finds you well. I am currently engaged in testing
device drivers in Linux kernel mode, and I have encountered various
types of kernel crashes during my testing process.

Among these, some examples of kernel crashes include OOPS, lockups and others.

I have a few questions regarding the handling of kernel crashes during testing:

When encountering a kernel crash during testing, is it advisable to
continue testing without rebooting the system? Or is it preferable to
reboot the system after each kernel crash and then resume testing?

Can the first kernel crash, whether it is an OOPS,  or any other type
crash, potentially lead to subsequent crashes of the same or different
types? If so, should debugging efforts focus only on the first kernel
crash, or should all subsequent crashes also be considered and
addressed?

In the event that the system needs to be rebooted after a kernel
crash, how can user space test utilities be informed that a kernel
crash has occurred? Additionally, how can the system be configured to
automatically reboot in the event of a kernel crash?

I would greatly appreciate any insights or best practices you can
share regarding the handling of kernel crashes during testing. Your
expertise and guidance on this matter would be invaluable to my
testing efforts.

Thank you very much for your time and assistance. I look forward to
your response.


-- 
Thanks,
Sekhar

