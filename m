Return-Path: <linux-kernel+bounces-371860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7A9A4168
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E661C23E40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C21F4296;
	Fri, 18 Oct 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="dQG4zaIX"
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCA1D9686
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262548; cv=none; b=Y6Rj7e6ytKFEGgl5leyfHb7K5cdaFif9rjJ6y4g79OgDWz+UkG42W8lY9UxWQ1ZCgKvYKdH5PfwIMkMxQT72axrFSu/teeK5qfIT+dwBmFIdzvh/Soj+l/3p53D+A2N+zd4sFZQut3aTUV/BD1KXcDl/VFw2MNNzBKGUE/xMhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262548; c=relaxed/simple;
	bh=A/724BhEZdtZmOczhOhvy5LRjcTRymfupxHC09g57ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEoDhaNS316//mmbpvjlx3waC0756WnBNw0P9nhREHNYR9F8CNPBYEwlGod6+KH0YU1PRJFMaRNcYVlT+GGQiBoqhrrsv1IyMAAEZVWy8yKAFsl4qhLTRSiW9/S3N7SRurnKqYYLrIrAM9c9F9cqyGMNqxtxsOaaG/kz0/bYSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=dQG4zaIX; arc=none smtp.client-ip=62.149.156.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 1o8JtbKaEcvwV1o8JtrU8d; Fri, 18 Oct 2024 16:39:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1729262356; bh=A/724BhEZdtZmOczhOhvy5LRjcTRymfupxHC09g57ys=;
	h=From:To:Subject:Date:MIME-Version;
	b=dQG4zaIXIZ7g9rCS0Ew51mwCQ28LIf5eaWpCZfKG/9t9gRGTeX94af4NuabDT5XLA
	 J+UunR6noURnRjijsqxZoTMtEDFjj70hj4zLVt1yTJBkPpClogNVs/qbryWiOow4SF
	 ruVyT2Rz3mfrDm0T+IUGMRduca8djNpHJTQRdrXXhus7x+ONvuooUt+JC/cKYokZ6Z
	 OBNy8nYsqrT8gPaDTJ9X09NMFPmE9Gnt0TzJDT31qoiRaFxk+f5W4Xf757nU8qc/Jt
	 CsFGC0yEhftH5RvI447Nksrtn+36dCRH6wzcvdn7+MglDiapfgKA4cGdR2VyD/bXpV
	 H+BWcOhaZC3WQ==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V1 0/4] Add PPS generators
Date: Fri, 18 Oct 2024 16:39:11 +0200
Message-Id: <20241018143915.3877425-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKM+yY/5E5Sa6WTRMRdh0E3rNyGCQWqcYtz3yVVlwjRWj7GHIKG4l7bbvPwwwZBMU8n9EzEFlX/XncKpmz3xR58uZPncsy9DFKNeNjNcRpXcaOQzUKtE
 h4S6SrYHvMAF1gBmdf6GyPWSv6nA1+W585TpRe4a/dcQlWBQcr4jPRwTDs3eFl6c/SdbDv9vy4V14C9CsVfG0+erRWJPECV5F1JecJ1C0NHQMg4+enL5DsQ7
 4TyXjW4cttVr73DDR7IQMJl+hxhGKdYzJDZfSU1t8tCkoaqDkTs5t8Z0Rg3n9a3klpazl9lAwgwde5Ci1e2rjdJVi0pBoSCQiRNE5eLPAsw2VvYscdSbYeyS
 mu9vmKmlQjP50kqWN9BLQ8AbVlZq5UBby4bJdn6F5wY4eJNwVHSgvMmM4iMQvNSgZrnlU+VrAQ8/qLzSKM7zYagou1VecvbUzfwHam0MOgfCsqMVIdONgLKy
 mzXx4trmmCqbFm+FRdEtep/kJ4Lk+6MxnJru1sIuCGUesSxtkhyi/KnfLcNffa7j2qu7FrWOdICW017GeYY8A35qnl0rTcc0ukOxVCAPX/7mnJlyi+4+9peg
 x+P/Rj4WY1BNuMO94lRbccjFbt/9kEh5gPpZYsUBnp5Ml9YYXfXTRU3UDfgHh68dJM8fJNrn+mXQvVQRlFNJbj+07xBDx9E2AqR36JyzqIUCNZHtd1GPE0kR
 k7rxaVEoQ+yWhmX4rlFli2nGtqLaaRg/

PPS generators are special hardware which are able to produce PPS
(Pulse Per Second) signals.

This patchset adds PPS generators class in order to have a well-defined
interface for these devices.

Changelog:

RFC -> V1:
    * char device reworked (get_device/set_device)
    * dummy driver has been moved in a separate patch
    * idr_ replaced with ida_* functions
    * fixes in include/uapi/linux/pps_gen.h
    * MAINTAINERS updated
    * new ioctl PPS_GEN_USESYSTEMCLOCK added
    * new ioctl PPS_GEN_FETCHEVENT added
    * .compat_ioctl dropped
    * WARN_ON() removed from pps_gen_cdev_release()
    * not needed pr_*() calls removed or replaced with dev_*()
    * more quite driver
    * name attribute dropped
    * white spaces removed

Rodolfo Giometti (4):
  drivers pps: add PPS generators support
  drivers pps/generators: add dummy PPS generator
  Documentation pps.rst: add PPS generators documentation
  Documentation ABI: add PPS generators documentation

 Documentation/ABI/testing/sysfs-pps-gen       |  44 +++
 Documentation/driver-api/pps.rst              |  40 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/pps/Makefile                          |   3 +-
 drivers/pps/generators/Kconfig                |  22 +-
 drivers/pps/generators/Makefile               |   4 +
 drivers/pps/generators/pps_gen-dummy.c        |  96 +++++
 drivers/pps/generators/pps_gen.c              | 344 ++++++++++++++++++
 drivers/pps/generators/sysfs.c                |  75 ++++
 include/linux/pps_gen_kernel.h                |  78 ++++
 include/uapi/linux/pps_gen.h                  |  37 ++
 12 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

-- 
2.34.1


