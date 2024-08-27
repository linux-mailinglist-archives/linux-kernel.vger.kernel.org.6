Return-Path: <linux-kernel+bounces-303941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99630961738
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2221F248B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB51D1F7D;
	Tue, 27 Aug 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UWrV2L9m"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4845024;
	Tue, 27 Aug 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784470; cv=none; b=oQqGmpQjxuTOviC56NUavYSb15HTgWzqoISrtC2eiKLtY102LqlUSZ8Qwoqb9pB2edI3xFobvwDw4Pckv13T0ebnWKPS/qLtpiclb9vdFuHDHJ0HQEwqfrzeZ8XYkqmRGa42Y050v7UMo5nhN0LikBeSSHuHDXRDl20CvJL+Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784470; c=relaxed/simple;
	bh=+EQAWGKZb9tJYOUhC/fba9LpQGC2ycTCPN1jTGoApqE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=p+vXtIbGlTZqMfCAuCRHIvKLHXK/uKsGdAXImBbJq+UQ3q/pXaQ7K9gsWPvSaV2Ry4gOLPFlpQlz/t3SlSvx0oYNM7ukj9Vnw0wBDYJ7HJ4Lnud6oqZMergXgQhgQYkXy4go1fmRIsXB+oShR6rt9EQEbS7xsWgrJ5Mhe+TgsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UWrV2L9m; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724784461; bh=9qCiBelyJVmqGBzhx8oNNy2uJiAGrAcqpi39XT+NXck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWrV2L9m5acZSFVpO0JOecCDl8p2n/ofC7yTBVjzaUlJWXGk3FwnoVen7MM5LXLPF
	 /CIZzj4CM/DwiWyFCQv4yzgpBiAJdHnTyyUSz4UZs+KeF7vwh8pg49r7EdjTxrc7Uh
	 dXqXw2KazDgT4hkP150M+DPyvE4H+OE6GLWqpXLQ=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id BDF298B9; Wed, 28 Aug 2024 02:47:31 +0800
X-QQ-mid: xmsmtpt1724784451tg1311myo
Message-ID: <tencent_830C97C456591F00B1FB19FF22E155062609@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJBylI9iu1DdeyH57Pbvc8AjfpfX5f2vppZGo4unQ2ho9MgztPUH
	 vuFmbQqduLRUuKmdK26OCD7zTJNPHHrNcoH6qmSrvFI+H53AKZoP3zLt6H45DIXTPnqxePeIozPc
	 pbHf7gVw6cbBpYi4rszRYianr6cR9RivT/mq+ul53OxWMNgDEmHTieTu2ybwR7IZztCKoXQ0Vu9I
	 EVg2piscNtp5jmfr2JNXIbxalfZA2KA8UUpGPblSaJV6Cw8j61dvurCiHrokueR85P/L4ECEIRj2
	 ggoP+nuVONSausl9ELWNzDYjEoHRrOMtUVsYYS6GKTzZFAut7XJcKZ8VMkIN91+MlGQmW2vGvgmb
	 KgMbj9Y5XTehXuXdjuSRNK9cnlj3Uo718lzADWTq2fMuJX0TQyBac2A2NMNOXoPeGJsZRrPIInT+
	 w1+Pod5oub+rBuCATNKFXAHvHv50DatHRdS6bpl/3vHuGxG/yWQKW7gAaum3oMRHtF0pyqvazo0D
	 7yI7bOREJQOKpGcOO4B6YRZTi0RVYNQXrtSiEQcHtfsg/rw7Rsi8bhXFzL/WjYq7UU+V3SLyWuGN
	 HrvfhNkMd2c1JJ/edyydzyDbb8HgKBBd1tVuZzlXhsau7pAop1h4tCh7MyqFEoRHkWBxtnKWyXt8
	 LJTyLSFWVja13A8HvnlEjUDuxqOD7AJGOuCrrZhLX5+2n5xZRFFLN/H52yYXqryeZo8r/3/ZHJQ+
	 WukkpcYCdfQY63cZcT/m6OzkrHsW5nDajZE0j74IxCwOkIxSbY7Bz7H6vbknYCjcMM95Aw+gBujb
	 9J1/F41RWsksd9uVVQhh7FIUOjnx38pn3hMUW6bZeL+Y7iPTGpaJPY1Xm74qoTVtqaBmJ59f6B1K
	 5F33hQ26Fgq8wKgeXd4+zEHPM6kviaJ685SK10BxskFnvMcA+x2Fs4MKkRuvBQGLN59tELJoviiR
	 kkI4J1+wQX6QmCITAuJN4q7q2/4yHtZnk4WAJ9EEkU9czWjEUXB12mcv6CLe4FM2vAPGioVy7vj7
	 LqqxYsVQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: jiping huang <huangjiping95@qq.com>
To: sboyd@kernel.org
Cc: huangjiping95@qq.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com
Subject: Re: [PATCH] clk: Delete init for local variable "best_crent_rate".  
Date: Wed, 28 Aug 2024 02:47:30 +0800
X-OQ-MSGID: <20240827184730.65178-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0f670049f3110f2be74f28f09e277b4e.sboyd@kernel.org>
References: <0f670049f3110f2be74f28f09e277b4e.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Oh God, another low-level mistake. Thank you for your help. I will correct my description later.
						Thanks!



