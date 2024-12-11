Return-Path: <linux-kernel+bounces-441154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE589ECA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9435C188CFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67298204F8C;
	Wed, 11 Dec 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="QJkLVcNo"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190881A8418
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913322; cv=none; b=eHMor0RZ5+VpcEwGSOYpg7C+GaEZoflFgZOvmrbWSoKpLy1E+tCBNWRe/gS2o1oYmFcK/UIeeoK2PNtRj5ZrPinO/fs5tUJg+yxifUauQz3ryAdeDO6IsuHdJIdPeyjPNvOJUFgc5v8/cFcatFtJO54CY/Uw0YxmBrNx0Fsoc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913322; c=relaxed/simple;
	bh=Gri998DLOiEDYK4hbdpUrZQng2GZm/AcgRTGKsy0hgU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SCXOWqOsQPp2Hqms8ZBaHANJtvQihi24lI4dioNZdPFa0OAPAXVZhEbr8MzJnrdeffvhfvsk0SBHWhu67HUr9JpuBclJr07muERrzqotlT5ULkQ7V/v4y0o/uIS9VnkvhBI35tIYKNAAJbWectYl6HbMGRLD8/lJsHfKuXOPn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=QJkLVcNo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7265c18d79bso2891040b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1733913320; x=1734518120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gri998DLOiEDYK4hbdpUrZQng2GZm/AcgRTGKsy0hgU=;
        b=QJkLVcNoxdgPp52vFmh6i/41sHvHDgd+xEIuMLN+rlntv2QsvL/YmC0kga9GxR3q9x
         LVuj+Hw2Y/gKwqTO6I9fQOHRuHV5wJ+IdIa5ydHP/5wje4svB0PQO2ligc7Wd/f5MaMM
         2KEP448BfMF0NLbvK7fOWvh3dd/cjb3CftZ7WGt/iN5ZmFVMUF1UCVleelIVYLFYETvC
         aXrXVjvP406LmLIvOSTCJWn8HiEylPNdcHXv6bkiY2OUwvg1F2qOeKghlTkhsNrr6X7L
         t9kq60izHvYyzVy2tohjRUiwtDYkFi2L9e6SgiaOl6k1kXwq0BX3YVKVi6KasVfZ0NPD
         04Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913320; x=1734518120;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gri998DLOiEDYK4hbdpUrZQng2GZm/AcgRTGKsy0hgU=;
        b=ezHvspDC9PPWLPeLqHbEkmLRXPimyfTubBmeQKhwLuNOn5KR8xt+OeFC4UFCeINyvl
         E4KEzmtOg++uyG4a8UHthu65McthaNpwHtSxqKjWWMPy+mUOwZNWWeglweLCRa8pc11r
         mT/SYOki7agW5kjJru9pRUBAnhZkBxRrh1sFbv4a2BXL16wW7P2JHBopdqvXVPXkQi0E
         qwjjJrc0rut5T7p4sadPZsxBJfkxBLcmivEe5kzTOyZPIlC0JfndcOtz7WyRw9YbONYl
         Usa9IJSjFg+K7XRIo49eITY/SdG2nYwxUUDaWbMm9Pdt1N3rtApxNzAZqVNLsFrlgVxk
         rjPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIfSsQOUVy8tXzoSnN4BlNJNznzj9en9XG0AZjl+zevqANgSJEmopuFo9yPnG6EbHbsPJE06lktMpwgT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rP//oO01XHhzxaM3WkIQnWi4/aNA4bb1i5UpJjv2aBA3w4wV
	eRyZbWwVX7m0WOEbGffnbKv371GCVueXD99X3q7Mlp7QetXAzm/qWF0Td5fHSenDum7P3NXioGt
	yYOi+0FrT/GisLSeqXC4PhgI2gyCZVcr4Fg4J
X-Gm-Gg: ASbGncvxlAWIekikVdhIHHBhzu5gGLtwiNgjQOI6v/0EL8xV6uASE7CGPovElzLz2Fx
	bh968W8DwP9GWkx+hnsiqFnxmKqj3M4soqZKzbDrXa7fZCGo3bPKbi1ZMqMmI/kzzdUInzw==
X-Google-Smtp-Source: AGHT+IGuULJtPxz5QYZMZX6hwgzdsEZpoUVDw6eBwgz/oyGbpW2xSkim8XZFkyP5S3F51bVfSW6pnozif+uCVPlwDjc=
X-Received: by 2002:a05:6a20:a11b:b0:1e1:bf3d:a18a with SMTP id
 adf61e73a8af0-1e1c138ab36mr4843973637.32.1733913320318; Wed, 11 Dec 2024
 02:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 11 Dec 2024 10:35:09 +0000
Message-ID: <CAHbf0-HuzfubZiLBsPhc24HrmS54sAsoDd_DVHPj+nTFqtuFAQ@mail.gmail.com>
Subject: Re: [PATCH v2 30/37] ALSA: seq: Automatic conversion of UMP events
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I'm not sure when this first appeared but I see the following when
compiling/linking with Clang 19.1.5

vmlinux.o: warning: objtool: cc_ev_to_ump_midi2+0x5a5: return with
modified stack frame

This is the only commit I can see that has cc_ev_to_ump_midi2 in it

Cheers

Mike

