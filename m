Return-Path: <linux-kernel+bounces-202171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC768FC8AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDE8B252EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265119048D;
	Wed,  5 Jun 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="JivFtTII"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B01946CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582220; cv=none; b=YETPkSKknXJkh5I3KSaOcAsUa8seaZEKEf3mKRrS8bdblX5HnoV4F/xd77/V18dqMec+xsqBPcJ5Kat8LkImRyv0+nFt1Ib4pWZRbC66kHSufJNhIOF6noYneQ8Gexd5TagI2zUdM7M12tNjLvag4jM6ulj6QlL0ompPVJa5Amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582220; c=relaxed/simple;
	bh=vpLOr0dZjlNrcP+uDYVX6bFYJ1hFVQa//bGLvxJUs7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFFNT4tOHj+J87OBYSzRjZ3kyt/FVnpV61iD7+nqFbYLy0e1P9S1fcGqxC1S0yjYuSQV8ipl90mMYkOTrZP/sn8dDXXmQsCMAOipXfQhITm7rcGXBnqXNG7pm0jEbjudqYkZKypOa0QTZBjRaAgdO1cYOc0/ZENSk2GIh1rUjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=JivFtTII; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240605101011422813dfadfd8a6770
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Jun 2024 12:10:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vpLOr0dZjlNrcP+uDYVX6bFYJ1hFVQa//bGLvxJUs7k=;
 b=JivFtTIIHAb7wTO7BmR06RAIRLCLR3QJYhhkTDKVc7Z6C54PdKe2f12u7zMkMc2DzwoyuM
 do3pjisYMEVC1gHj3BU2KXj0KDyXGHFsUtenteuoE9CU2M+qwaMfKYv/0X/6jKHVrO5KrYR0
 Kv+fSQOkOKML7JfK8qWa+cVeGoloM=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: mpearson-lenovo@squebb.ca
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	diogo.ivo@tecnico.ulisboa.pt
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info instead of error
Date: Wed,  5 Jun 2024 11:10:10 +0100
Message-ID: <20240605101010.150645-1-diogo.ivo@siemens.com>
In-Reply-To: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
References: <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Hi Mark,

Do these devices report GET_PDOS support as a response to GET_CAPABILITY?
If they don't I think the best way of addressing this would be to guard
against executing this command for devices without "PDO details supported"
(in ucsi_get_pdos() for example).

Best regards,
Diogo

