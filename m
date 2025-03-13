Return-Path: <linux-kernel+bounces-559886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CEA5FACF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457E419C6FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42826FD84;
	Thu, 13 Mar 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZix7BuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7MMQjnnz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55615269CFD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881637; cv=none; b=MTJaGAVwphR8jIN2D+1grqr4Wc7PRk4kiUuI9SksjNHJG8STteCwV+sMQyi+/s/9y+LP6M7fTA1M7BI/FcapxgKEnwJaqRoFBomyx55wi5wXxQz3JJcLZqiUGO4mm+c8Iat8SKK8Jofeiz8+tKXfbo2OO2XYwEQ02vXtY1E571Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881637; c=relaxed/simple;
	bh=AA7DB44SqdT/Vv7gn7STjpwrmASbclM1h5N06XTG4OE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LO+/JN3oH5iSVNTCYl3uLeZIN9Y/iFqRDTzQ8fvzfrbEByZbSVJmrFK6C9jr542MpdlsTjTvhcNZlHsK2XaOa9XtzhmhvT85xVoUgfi6m6s8TUv9B07vyvdadcJTtDZEv1GAScn/BsVBGhPO92UcUIravnzRdgTWAcrFWHas55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZix7BuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7MMQjnnz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155915.861963285@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AVjQ0jXNc7+mnch6QGwXLNBX9mH745IofOEWtCCFZJU=;
	b=JZix7BuBUta2A5MWL6RzaWEG+03Cxrj86jr3MPgW+Vu/Zt4579hyikQp0Hju++yxqy7WIf
	iHBqkocy/ci5fl20D6eEQolLHHiYpTLifZhkN6nSRKt9T5bEs/t+eyZ3MMy2ESxCUlRY7c
	PD2+byMegw/kfjlm6Oq47q0J25anPT4hGW4bmdEoUIg2UiDS/uUMjM8Jyc7+dp8RqF6tDf
	BB0ZYVFZp5NdW37CBWSWdefAkbhc9eDjLpP4MRPYT0IXCSWP4YNf8uSA4aBBwTw4YFn3pV
	U4l3tXvj56RiPjvDNZr8lUvh+JGtrSgVCevdSQMT3f5yxVPyIWCxyj5vsCfN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AVjQ0jXNc7+mnch6QGwXLNBX9mH745IofOEWtCCFZJU=;
	b=7MMQjnnznzfo/pm5EdBk96RMZwVl3PIJ1Qhhxv74X0e8X4PrqjU3sB5o0fHTRXHxYUIZcN
	htDwyVBsSmbepACQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 29/46] genirq/manage: Cleanup kernel doc comments
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:00:32 +0100 (CET)

Get rid of the extra tab to make it consistent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |  570 +++++++++++++++++++++++++---------------------------
 1 file changed, 276 insertions(+), 294 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -74,26 +74,25 @@ static void __synchronize_hardirq(struct
 }
 
 /**
- *	synchronize_hardirq - wait for pending hard IRQ handlers (on other CPUs)
- *	@irq: interrupt number to wait for
+ * synchronize_hardirq - wait for pending hard IRQ handlers (on other CPUs)
+ * @irq: interrupt number to wait for
  *
- *	This function waits for any pending hard IRQ handlers for this
- *	interrupt to complete before returning. If you use this
- *	function while holding a resource the IRQ handler may need you
- *	will deadlock. It does not take associated threaded handlers
- *	into account.
- *
- *	Do not use this for shutdown scenarios where you must be sure
- *	that all parts (hardirq and threaded handler) have completed.
- *
- *	Returns: false if a threaded handler is active.
- *
- *	This function may be called - with care - from IRQ context.
- *
- *	It does not check whether there is an interrupt in flight at the
- *	hardware level, but not serviced yet, as this might deadlock when
- *	called with interrupts disabled and the target CPU of the interrupt
- *	is the current CPU.
+ * This function waits for any pending hard IRQ handlers for this interrupt
+ * to complete before returning. If you use this function while holding a
+ * resource the IRQ handler may need you will deadlock. It does not take
+ * associated threaded handlers into account.
+ *
+ * Do not use this for shutdown scenarios where you must be sure that all
+ * parts (hardirq and threaded handler) have completed.
+ *
+ * Returns: false if a threaded handler is active.
+ *
+ * This function may be called - with care - from IRQ context.
+ *
+ * It does not check whether there is an interrupt in flight at the
+ * hardware level, but not serviced yet, as this might deadlock when called
+ * with interrupts disabled and the target CPU of the interrupt is the
+ * current CPU.
  */
 bool synchronize_hardirq(unsigned int irq)
 {
@@ -119,19 +118,19 @@ static void __synchronize_irq(struct irq
 }
 
 /**
- *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
- *	@irq: interrupt number to wait for
+ * synchronize_irq - wait for pending IRQ handlers (on other CPUs)
+ * @irq: interrupt number to wait for
  *
- *	This function waits for any pending IRQ handlers for this interrupt
- *	to complete before returning. If you use this function while
- *	holding a resource the IRQ handler may need you will deadlock.
- *
- *	Can only be called from preemptible code as it might sleep when
- *	an interrupt thread is associated to @irq.
- *
- *	It optionally makes sure (when the irq chip supports that method)
- *	that the interrupt is not pending in any CPU and waiting for
- *	service.
+ * This function waits for any pending IRQ handlers for this interrupt to
+ * complete before returning. If you use this function while holding a
+ * resource the IRQ handler may need you will deadlock.
+ *
+ * Can only be called from preemptible code as it might sleep when
+ * an interrupt thread is associated to @irq.
+ *
+ * It optionally makes sure (when the irq chip supports that method)
+ * that the interrupt is not pending in any CPU and waiting for
+ * service.
  */
 void synchronize_irq(unsigned int irq)
 {
@@ -154,8 +153,8 @@ static bool __irq_can_set_affinity(struc
 }
 
 /**
- *	irq_can_set_affinity - Check if the affinity of a given irq can be set
- *	@irq:		Interrupt to check
+ * irq_can_set_affinity - Check if the affinity of a given irq can be set
+ * @irq:	Interrupt to check
  *
  */
 int irq_can_set_affinity(unsigned int irq)
@@ -179,13 +178,13 @@ bool irq_can_set_affinity_usr(unsigned i
 }
 
 /**
- *	irq_set_thread_affinity - Notify irq threads to adjust affinity
- *	@desc:		irq descriptor which has affinity changed
+ * irq_set_thread_affinity - Notify irq threads to adjust affinity
+ * @desc:	irq descriptor which has affinity changed
  *
- *	We just set IRQTF_AFFINITY and delegate the affinity setting
- *	to the interrupt thread itself. We can not call
- *	set_cpus_allowed_ptr() here as we hold desc->lock and this
- *	code can be called from hard interrupt context.
+ * Just set IRQTF_AFFINITY and delegate the affinity setting to the
+ * interrupt thread itself. We can not call set_cpus_allowed_ptr() here as
+ * we hold desc->lock and this code can be called from hard interrupt
+ * context.
  */
 void irq_set_thread_affinity(struct irq_desc *desc)
 {
@@ -541,18 +540,17 @@ static void irq_affinity_notify(struct w
 }
 
 /**
- *	irq_set_affinity_notifier - control notification of IRQ affinity changes
- *	@irq:		Interrupt for which to enable/disable notification
- *	@notify:	Context for notification, or %NULL to disable
- *			notification.  Function pointers must be initialised;
- *			the other fields will be initialised by this function.
- *
- *	Must be called in process context.  Notification may only be enabled
- *	after the IRQ is allocated and must be disabled before the IRQ is
- *	freed using free_irq().
+ * irq_set_affinity_notifier - control notification of IRQ affinity changes
+ * @irq:	Interrupt for which to enable/disable notification
+ * @notify:	Context for notification, or %NULL to disable
+ *		notification.  Function pointers must be initialised;
+ *		the other fields will be initialised by this function.
+ *
+ * Must be called in process context.  Notification may only be enabled
+ * after the IRQ is allocated and must be disabled before the IRQ is freed
+ * using free_irq().
  */
-int
-irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
+int irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_affinity_notify *old_notify;
@@ -643,15 +641,14 @@ int irq_setup_affinity(struct irq_desc *
 
 
 /**
- *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
- *	@irq: interrupt number to set affinity
- *	@vcpu_info: vCPU specific data or pointer to a percpu array of vCPU
- *	            specific data for percpu_devid interrupts
- *
- *	This function uses the vCPU specific data to set the vCPU
- *	affinity for an irq. The vCPU specific data is passed from
- *	outside, such as KVM. One example code path is as below:
- *	KVM -> IOMMU -> irq_set_vcpu_affinity().
+ * irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
+ * @irq:	interrupt number to set affinity
+ * @vcpu_info:	vCPU specific data or pointer to a percpu array of vCPU
+ *		specific data for percpu_devid interrupts
+ *
+ * This function uses the vCPU specific data to set the vCPU affinity for
+ * an irq. The vCPU specific data is passed from outside, such as KVM. One
+ * example code path is as below: KVM -> IOMMU -> irq_set_vcpu_affinity().
  */
 int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
 {
@@ -703,15 +700,15 @@ static int __disable_irq_nosync(unsigned
 }
 
 /**
- *	disable_irq_nosync - disable an irq without waiting
- *	@irq: Interrupt to disable
+ * disable_irq_nosync - disable an irq without waiting
+ * @irq: Interrupt to disable
  *
- *	Disable the selected interrupt line.  Disables and Enables are
- *	nested.
- *	Unlike disable_irq(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
+ * Disable the selected interrupt line.  Disables and Enables are
+ * nested.
+ * Unlike disable_irq(), this function does not ensure existing
+ * instances of the IRQ handler have completed before returning.
  *
- *	This function may be called from IRQ context.
+ * This function may be called from IRQ context.
  */
 void disable_irq_nosync(unsigned int irq)
 {
@@ -720,17 +717,17 @@ void disable_irq_nosync(unsigned int irq
 EXPORT_SYMBOL(disable_irq_nosync);
 
 /**
- *	disable_irq - disable an irq and wait for completion
- *	@irq: Interrupt to disable
+ * disable_irq - disable an irq and wait for completion
+ * @irq: Interrupt to disable
+ *
+ * Disable the selected interrupt line.  Enables and Disables are nested.
  *
- *	Disable the selected interrupt line.  Enables and Disables are
- *	nested.
- *	This function waits for any pending IRQ handlers for this interrupt
- *	to complete before returning. If you use this function while
- *	holding a resource the IRQ handler may need you will deadlock.
+ * This function waits for any pending IRQ handlers for this interrupt to
+ * complete before returning. If you use this function while holding a
+ * resource the IRQ handler may need you will deadlock.
  *
- *	Can only be called from preemptible code as it might sleep when
- *	an interrupt thread is associated to @irq.
+ * Can only be called from preemptible code as it might sleep when an
+ * interrupt thread is associated to @irq.
  *
  */
 void disable_irq(unsigned int irq)
@@ -742,40 +739,39 @@ void disable_irq(unsigned int irq)
 EXPORT_SYMBOL(disable_irq);
 
 /**
- *	disable_hardirq - disables an irq and waits for hardirq completion
- *	@irq: Interrupt to disable
+ * disable_hardirq - disables an irq and waits for hardirq completion
+ * @irq: Interrupt to disable
  *
- *	Disable the selected interrupt line.  Enables and Disables are
- *	nested.
- *	This function waits for any pending hard IRQ handlers for this
- *	interrupt to complete before returning. If you use this function while
- *	holding a resource the hard IRQ handler may need you will deadlock.
+ * Disable the selected interrupt line.  Enables and Disables are nested.
  *
- *	When used to optimistically disable an interrupt from atomic context
- *	the return value must be checked.
+ * This function waits for any pending hard IRQ handlers for this interrupt
+ * to complete before returning. If you use this function while holding a
+ * resource the hard IRQ handler may need you will deadlock.
  *
- *	Returns: false if a threaded handler is active.
+ * When used to optimistically disable an interrupt from atomic context the
+ * return value must be checked.
  *
- *	This function may be called - with care - from IRQ context.
+ * Returns: false if a threaded handler is active.
+ *
+ * This function may be called - with care - from IRQ context.
  */
 bool disable_hardirq(unsigned int irq)
 {
 	if (!__disable_irq_nosync(irq))
 		return synchronize_hardirq(irq);
-
 	return false;
 }
 EXPORT_SYMBOL_GPL(disable_hardirq);
 
 /**
- *	disable_nmi_nosync - disable an nmi without waiting
- *	@irq: Interrupt to disable
+ * disable_nmi_nosync - disable an nmi without waiting
+ * @irq: Interrupt to disable
+ *
+ * Disable the selected interrupt line. Disables and enables are nested.
  *
- *	Disable the selected interrupt line. Disables and enables are
- *	nested.
- *	The interrupt to disable must have been requested through request_nmi.
- *	Unlike disable_nmi(), this function does not ensure existing
- *	instances of the IRQ handler have completed before returning.
+ * The interrupt to disable must have been requested through request_nmi.
+ * Unlike disable_nmi(), this function does not ensure existing
+ * instances of the IRQ handler have completed before returning.
  */
 void disable_nmi_nosync(unsigned int irq)
 {
@@ -815,15 +811,14 @@ void __enable_irq(struct irq_desc *desc)
 }
 
 /**
- *	enable_irq - enable handling of an irq
- *	@irq: Interrupt to enable
+ * enable_irq - enable handling of an irq
+ * @irq: Interrupt to enable
  *
- *	Undoes the effect of one call to disable_irq().  If this
- *	matches the last disable, processing of interrupts on this
- *	IRQ line is re-enabled.
+ * Undoes the effect of one call to disable_irq().  If this matches the
+ * last disable, processing of interrupts on this IRQ line is re-enabled.
  *
- *	This function may be called from IRQ context only when
- *	desc->irq_data.chip->bus_lock and desc->chip->bus_sync_unlock are NULL !
+ * This function may be called from IRQ context only when
+ * desc->irq_data.chip->bus_lock and desc->chip->bus_sync_unlock are NULL !
  */
 void enable_irq(unsigned int irq)
 {
@@ -843,13 +838,12 @@ void enable_irq(unsigned int irq)
 EXPORT_SYMBOL(enable_irq);
 
 /**
- *	enable_nmi - enable handling of an nmi
- *	@irq: Interrupt to enable
+ * enable_nmi - enable handling of an nmi
+ * @irq: Interrupt to enable
  *
- *	The interrupt to enable must have been requested through request_nmi.
- *	Undoes the effect of one call to disable_nmi(). If this
- *	matches the last disable, processing of interrupts on this
- *	IRQ line is re-enabled.
+ * The interrupt to enable must have been requested through request_nmi.
+ * Undoes the effect of one call to disable_nmi(). If this matches the last
+ * disable, processing of interrupts on this IRQ line is re-enabled.
  */
 void enable_nmi(unsigned int irq)
 {
@@ -871,23 +865,22 @@ static int set_irq_wake_real(unsigned in
 }
 
 /**
- *	irq_set_irq_wake - control irq power management wakeup
- *	@irq:	interrupt to control
- *	@on:	enable/disable power management wakeup
- *
- *	Enable/disable power management wakeup mode, which is
- *	disabled by default.  Enables and disables must match,
- *	just as they match for non-wakeup mode support.
- *
- *	Wakeup mode lets this IRQ wake the system from sleep
- *	states like "suspend to RAM".
- *
- *	Note: irq enable/disable state is completely orthogonal
- *	to the enable/disable state of irq wake. An irq can be
- *	disabled with disable_irq() and still wake the system as
- *	long as the irq has wake enabled. If this does not hold,
- *	then the underlying irq chip and the related driver need
- *	to be investigated.
+ * irq_set_irq_wake - control irq power management wakeup
+ * @irq:	interrupt to control
+ * @on:	enable/disable power management wakeup
+ *
+ * Enable/disable power management wakeup mode, which is disabled by
+ * default.  Enables and disables must match, just as they match for
+ * non-wakeup mode support.
+ *
+ * Wakeup mode lets this IRQ wake the system from sleep states like
+ * "suspend to RAM".
+ *
+ * Note: irq enable/disable state is completely orthogonal to the
+ * enable/disable state of irq wake. An irq can be disabled with
+ * disable_irq() and still wake the system as long as the irq has wake
+ * enabled. If this does not hold, then the underlying irq chip and the
+ * related driver need to be investigated.
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
@@ -1332,10 +1325,9 @@ static int irq_thread(void *data)
 }
 
 /**
- *	irq_wake_thread - wake the irq thread for the action identified by dev_id
- *	@irq:		Interrupt line
- *	@dev_id:	Device identity for which the thread should be woken
- *
+ * irq_wake_thread - wake the irq thread for the action identified by dev_id
+ * @irq:	Interrupt line
+ * @dev_id:	Device identity for which the thread should be woken
  */
 void irq_wake_thread(unsigned int irq, void *dev_id)
 {
@@ -2003,20 +1995,19 @@ static struct irqaction *__free_irq(stru
 }
 
 /**
- *	free_irq - free an interrupt allocated with request_irq
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
- *
- *	Remove an interrupt handler. The handler is removed and if the
- *	interrupt line is no longer in use by any driver it is disabled.
- *	On a shared IRQ the caller must ensure the interrupt is disabled
- *	on the card it drives before calling this function. The function
- *	does not return until any executing interrupts for this IRQ
- *	have completed.
+ * free_irq - free an interrupt allocated with request_irq
+ * @irq:	Interrupt line to free
+ * @dev_id:	Device identity to free
+ *
+ * Remove an interrupt handler. The handler is removed and if the interrupt
+ * line is no longer in use by any driver it is disabled.  On a shared IRQ
+ * the caller must ensure the interrupt is disabled on the card it drives
+ * before calling this function. The function does not return until any
+ * executing interrupts for this IRQ have completed.
  *
- *	This function must not be called from interrupt context.
+ * This function must not be called from interrupt context.
  *
- *	Returns the devname argument passed to request_irq.
+ * Returns the devname argument passed to request_irq.
  */
 const void *free_irq(unsigned int irq, void *dev_id)
 {
@@ -2097,42 +2088,40 @@ const void *free_nmi(unsigned int irq, v
 }
 
 /**
- *	request_threaded_irq - allocate an interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs.
- *		  Primary handler for threaded interrupts.
- *		  If handler is NULL and thread_fn != NULL
- *		  the default primary handler is installed.
- *	@thread_fn: Function called from the irq handler thread
- *		    If NULL, no irq thread is created
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. From the point this
- *	call is made your handler function may be invoked. Since
- *	your handler function must clear any interrupt the board
- *	raises, you must take care both to initialise your hardware
- *	and to set up the interrupt handler in the right order.
- *
- *	If you want to set up a threaded irq handler for your device
- *	then you need to supply @handler and @thread_fn. @handler is
- *	still called in hard interrupt context and has to check
- *	whether the interrupt originates from the device. If yes it
- *	needs to disable the interrupt on the device and return
- *	IRQ_WAKE_THREAD which will wake up the handler thread and run
- *	@thread_fn. This split handler design is necessary to support
- *	shared interrupts.
- *
- *	Dev_id must be globally unique. Normally the address of the
- *	device data structure is used as the cookie. Since the handler
- *	receives this value it makes sense to use it.
+ * request_threaded_irq - allocate an interrupt line
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs.
+ *		Primary handler for threaded interrupts.
+ *		If handler is NULL and thread_fn != NULL
+ *		the default primary handler is installed.
+ * @thread_fn:	Function called from the irq handler thread
+ *		If NULL, no irq thread is created
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * This call allocates interrupt resources and enables the interrupt line
+ * and IRQ handling. From the point this call is made your handler function
+ * may be invoked. Since your handler function must clear any interrupt the
+ * board raises, you must take care both to initialise your hardware and to
+ * set up the interrupt handler in the right order.
+ *
+ * If you want to set up a threaded irq handler for your device then you
+ * need to supply @handler and @thread_fn. @handler is still called in hard
+ * interrupt context and has to check whether the interrupt originates from
+ * the device. If yes it needs to disable the interrupt on the device and
+ * return IRQ_WAKE_THREAD which will wake up the handler thread and run
+ * @thread_fn. This split handler design is necessary to support shared
+ * interrupts.
+ *
+ * @dev_id must be globally unique. Normally the address of the device data
+ * structure is used as the cookie. Since the handler receives this value
+ * it makes sense to use it.
  *
- *	If your interrupt is shared you must pass a non NULL dev_id
- *	as this is required when freeing the interrupt.
+ * If your interrupt is shared you must pass a non NULL dev_id as this is
+ * required when freeing the interrupt.
  *
- *	Flags:
+ * Flags:
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
@@ -2230,21 +2219,20 @@ int request_threaded_irq(unsigned int ir
 EXPORT_SYMBOL(request_threaded_irq);
 
 /**
- *	request_any_context_irq - allocate an interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs.
- *		  Threaded handler for threaded interrupts.
- *	@flags: Interrupt type flags
- *	@name: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. It selects either a
- *	hardirq or threaded handling method depending on the
- *	context.
+ * request_any_context_irq - allocate an interrupt line
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs.
+ *		Threaded handler for threaded interrupts.
+ * @flags:	Interrupt type flags
+ * @name:	An ascii name for the claiming device
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * This call allocates interrupt resources and enables the interrupt line
+ * and IRQ handling. It selects either a hardirq or threaded handling
+ * method depending on the context.
  *
- *	On failure, it returns a negative value. On success,
- *	it returns either IRQC_IS_HARDIRQ or IRQC_IS_NESTED.
+ * Returns: On failure, it returns a negative value. On success, it returns either
+ * IRQC_IS_HARDIRQ or IRQC_IS_NESTED.
  */
 int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 			    unsigned long flags, const char *name, void *dev_id)
@@ -2271,30 +2259,29 @@ int request_any_context_irq(unsigned int
 EXPORT_SYMBOL_GPL(request_any_context_irq);
 
 /**
- *	request_nmi - allocate an interrupt line for NMI delivery
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs.
- *		  Threaded handler for threaded interrupts.
- *	@irqflags: Interrupt type flags
- *	@name: An ascii name for the claiming device
- *	@dev_id: A cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt line and IRQ handling. It sets up the IRQ line
- *	to be handled as an NMI.
- *
- *	An interrupt line delivering NMIs cannot be shared and IRQ handling
- *	cannot be threaded.
- *
- *	Interrupt lines requested for NMI delivering must produce per cpu
- *	interrupts and have auto enabling setting disabled.
- *
- *	Dev_id must be globally unique. Normally the address of the
- *	device data structure is used as the cookie. Since the handler
- *	receives this value it makes sense to use it.
+ * request_nmi - allocate an interrupt line for NMI delivery
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs.
+ *		Threaded handler for threaded interrupts.
+ * @irqflags:	Interrupt type flags
+ * @name:	An ascii name for the claiming device
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * This call allocates interrupt resources and enables the interrupt line
+ * and IRQ handling. It sets up the IRQ line to be handled as an NMI.
+ *
+ * An interrupt line delivering NMIs cannot be shared and IRQ handling
+ * cannot be threaded.
+ *
+ * Interrupt lines requested for NMI delivering must produce per cpu
+ * interrupts and have auto enabling setting disabled.
+ *
+ * @dev_id must be globally unique. Normally the address of the device data
+ * structure is used as the cookie. Since the handler receives this value
+ * it makes sense to use it.
  *
- *	If the interrupt line cannot be used to deliver NMIs, function
- *	will fail and return a negative value.
+ * If the interrupt line cannot be used to deliver NMIs, function will fail
+ * and return a negative value.
  */
 int request_nmi(unsigned int irq, irq_handler_t handler,
 		unsigned long irqflags, const char *name, void *dev_id)
@@ -2496,9 +2483,9 @@ static struct irqaction *__free_percpu_i
 }
 
 /**
- *	remove_percpu_irq - free a per-cpu interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
+ * remove_percpu_irq - free a per-cpu interrupt
+ * @irq:	Interrupt line to free
+ * @act:	irqaction for the interrupt
  *
  * Used to remove interrupts statically setup by the early boot process.
  */
@@ -2507,20 +2494,20 @@ void remove_percpu_irq(unsigned int irq,
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc && irq_settings_is_per_cpu_devid(desc))
-	    __free_percpu_irq(irq, act->percpu_dev_id);
+		__free_percpu_irq(irq, act->percpu_dev_id);
 }
 
 /**
- *	free_percpu_irq - free an interrupt allocated with request_percpu_irq
- *	@irq: Interrupt line to free
- *	@dev_id: Device identity to free
+ * free_percpu_irq - free an interrupt allocated with request_percpu_irq
+ * @irq:	Interrupt line to free
+ * @dev_id:	Device identity to free
  *
- *	Remove a percpu interrupt handler. The handler is removed, but
- *	the interrupt line is not disabled. This must be done on each
- *	CPU before calling this function. The function does not return
- *	until any executing interrupts for this IRQ have completed.
+ * Remove a percpu interrupt handler. The handler is removed, but the
+ * interrupt line is not disabled. This must be done on each CPU before
+ * calling this function. The function does not return until any executing
+ * interrupts for this IRQ have completed.
  *
- *	This function must not be called from interrupt context.
+ * This function must not be called from interrupt context.
  */
 void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 {
@@ -2549,9 +2536,9 @@ void free_percpu_nmi(unsigned int irq, v
 }
 
 /**
- *	setup_percpu_irq - setup a per-cpu interrupt
- *	@irq: Interrupt line to setup
- *	@act: irqaction for the interrupt
+ * setup_percpu_irq - setup a per-cpu interrupt
+ * @irq:	Interrupt line to setup
+ * @act:	irqaction for the interrupt
  *
  * Used to statically setup per-cpu interrupts in the early boot process.
  */
@@ -2576,21 +2563,20 @@ int setup_percpu_irq(unsigned int irq, s
 }
 
 /**
- *	__request_percpu_irq - allocate a percpu interrupt line
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs.
- *	@flags: Interrupt type flags (IRQF_TIMER only)
- *	@devname: An ascii name for the claiming device
- *	@dev_id: A percpu cookie passed back to the handler function
- *
- *	This call allocates interrupt resources and enables the
- *	interrupt on the local CPU. If the interrupt is supposed to be
- *	enabled on other CPUs, it has to be done on each CPU using
- *	enable_percpu_irq().
- *
- *	Dev_id must be globally unique. It is a per-cpu variable, and
- *	the handler gets called with the interrupted CPU's instance of
- *	that variable.
+ * __request_percpu_irq - allocate a percpu interrupt line
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs.
+ * @flags:	Interrupt type flags (IRQF_TIMER only)
+ * @devname:	An ascii name for the claiming device
+ * @dev_id:	A percpu cookie passed back to the handler function
+ *
+ * This call allocates interrupt resources and enables the interrupt on the
+ * local CPU. If the interrupt is supposed to be enabled on other CPUs, it
+ * has to be done on each CPU using enable_percpu_irq().
+ *
+ * @dev_id must be globally unique. It is a per-cpu variable, and
+ * the handler gets called with the interrupted CPU's instance of
+ * that variable.
  */
 int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 			 unsigned long flags, const char *devname,
@@ -2638,25 +2624,25 @@ int __request_percpu_irq(unsigned int ir
 EXPORT_SYMBOL_GPL(__request_percpu_irq);
 
 /**
- *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs.
- *	@name: An ascii name for the claiming device
- *	@dev_id: A percpu cookie passed back to the handler function
- *
- *	This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
- *	have to be setup on each CPU by calling prepare_percpu_nmi() before
- *	being enabled on the same CPU by using enable_percpu_nmi().
- *
- *	Dev_id must be globally unique. It is a per-cpu variable, and
- *	the handler gets called with the interrupted CPU's instance of
- *	that variable.
+ * request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the IRQ occurs.
+ * @name:	An ascii name for the claiming device
+ * @dev_id:	A percpu cookie passed back to the handler function
+ *
+ * This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
+ * have to be setup on each CPU by calling prepare_percpu_nmi() before
+ * being enabled on the same CPU by using enable_percpu_nmi().
+ *
+ * @dev_id must be globally unique. It is a per-cpu variable, and the
+ * handler gets called with the interrupted CPU's instance of that
+ * variable.
  *
- *	Interrupt lines requested for NMI delivering should have auto enabling
- *	setting disabled.
+ * Interrupt lines requested for NMI delivering should have auto enabling
+ * setting disabled.
  *
- *	If the interrupt line cannot be used to deliver NMIs, function
- *	will fail returning a negative value.
+ * If the interrupt line cannot be used to deliver NMIs, function
+ * will fail returning a negative value.
  */
 int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		       const char *name, void __percpu *dev_id)
@@ -2714,17 +2700,17 @@ int request_percpu_nmi(unsigned int irq,
 }
 
 /**
- *	prepare_percpu_nmi - performs CPU local setup for NMI delivery
- *	@irq: Interrupt line to prepare for NMI delivery
+ * prepare_percpu_nmi - performs CPU local setup for NMI delivery
+ * @irq: Interrupt line to prepare for NMI delivery
  *
- *	This call prepares an interrupt line to deliver NMI on the current CPU,
- *	before that interrupt line gets enabled with enable_percpu_nmi().
+ * This call prepares an interrupt line to deliver NMI on the current CPU,
+ * before that interrupt line gets enabled with enable_percpu_nmi().
  *
- *	As a CPU local operation, this should be called from non-preemptible
- *	context.
+ * As a CPU local operation, this should be called from non-preemptible
+ * context.
  *
- *	If the interrupt line cannot be used to deliver NMIs, function
- *	will fail returning a negative value.
+ * If the interrupt line cannot be used to deliver NMIs, function will fail
+ * returning a negative value.
  */
 int prepare_percpu_nmi(unsigned int irq)
 {
@@ -2758,16 +2744,14 @@ int prepare_percpu_nmi(unsigned int irq)
 }
 
 /**
- *	teardown_percpu_nmi - undoes NMI setup of IRQ line
- *	@irq: Interrupt line from which CPU local NMI configuration should be
- *	      removed
- *
- *	This call undoes the setup done by prepare_percpu_nmi().
+ * teardown_percpu_nmi - undoes NMI setup of IRQ line
+ * @irq: Interrupt line from which CPU local NMI configuration should be removed
  *
- *	IRQ line should not be enabled for the current CPU.
+ * This call undoes the setup done by prepare_percpu_nmi().
  *
- *	As a CPU local operation, this should be called from non-preemptible
- *	context.
+ * IRQ line should not be enabled for the current CPU.
+ * As a CPU local operation, this should be called from non-preemptible
+ * context.
  */
 void teardown_percpu_nmi(unsigned int irq)
 {
@@ -2814,17 +2798,16 @@ int __irq_get_irqchip_state(struct irq_d
 }
 
 /**
- *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
- *	@irq: Interrupt line that is forwarded to a VM
- *	@which: One of IRQCHIP_STATE_* the caller wants to know about
- *	@state: a pointer to a boolean where the state is to be stored
- *
- *	This call snapshots the internal irqchip state of an
- *	interrupt, returning into @state the bit corresponding to
- *	stage @which
+ * irq_get_irqchip_state - returns the irqchip state of a interrupt.
+ * @irq:	Interrupt line that is forwarded to a VM
+ * @which:	One of IRQCHIP_STATE_* the caller wants to know about
+ * @state:	a pointer to a boolean where the state is to be stored
+ *
+ * This call snapshots the internal irqchip state of an interrupt,
+ * returning into @state the bit corresponding to stage @which
  *
- *	This function should be called with preemption disabled if the
- *	interrupt controller has per-cpu registers.
+ * This function should be called with preemption disabled if the interrupt
+ * controller has per-cpu registers.
  */
 int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 			  bool *state)
@@ -2848,19 +2831,18 @@ int irq_get_irqchip_state(unsigned int i
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
 
 /**
- *	irq_set_irqchip_state - set the state of a forwarded interrupt.
- *	@irq: Interrupt line that is forwarded to a VM
- *	@which: State to be restored (one of IRQCHIP_STATE_*)
- *	@val: Value corresponding to @which
+ * irq_set_irqchip_state - set the state of a forwarded interrupt.
+ * @irq:	Interrupt line that is forwarded to a VM
+ * @which:	State to be restored (one of IRQCHIP_STATE_*)
+ * @val:	Value corresponding to @which
  *
- *	This call sets the internal irqchip state of an interrupt,
- *	depending on the value of @which.
+ * This call sets the internal irqchip state of an interrupt, depending on
+ * the value of @which.
  *
- *	This function should be called with migration disabled if the
- *	interrupt controller has per-cpu registers.
+ * This function should be called with migration disabled if the interrupt
+ * controller has per-cpu registers.
  */
-int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-			  bool val)
+int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool val)
 {
 	struct irq_desc *desc;
 	struct irq_data *data;


